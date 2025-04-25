from __future__ import annotations

from typing import Annotated, Any, Self

from pydantic import BaseModel, BeforeValidator, Field, TypeAdapter

from ansible.errors import AnsibleFilterError


def normalize_package(input: Any) -> Any:
    if isinstance(input, str):
        return {"packages": [input]}
    return input


def normalize_packages(input: Any) -> Any:
    if isinstance(input, list):
        return [normalize_package(it) for it in input]
    return input


class Package(BaseModel):
    when: bool = True
    packages: list[str] = Field(default_factory=list)
    services: list[str] = Field(default_factory=list)

    def __iadd__(self, other: Package) -> Self:
        self.packages += other.packages
        self.services += other.services
        return self


class FilterModule(object):
    def filters(self):
        return {
            "from_packages": self.from_packages,
        }

    def from_packages(self, input: object):
        parser: TypeAdapter[list[Package]] = TypeAdapter(
            Annotated[list[Package], BeforeValidator(normalize_packages)]
        )
        try:
            result = Package()
            for package in parser.validate_python(input, strict=True):
                if package.when:
                    result += package
            return result.model_dump()
        except Exception as err:
            raise AnsibleFilterError(message=str(err))
