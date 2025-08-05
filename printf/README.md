# printf
printf를 어셈블리어로 구현해보는 프로젝트입니다. 자세한 설명은 각 파일 속 주석으로 설명되어 있습니다.

## How to play
nasm과 ld, make가 필요합니다.
```
make
./a
```
위 커맨드로 실행해볼 수 있어요!<br>
linux x86-64 환경에서만 작동합니다.

## structure
- main.asm : printf를 사용해볼 수 있는 파일입니다
- printf.asm : printf가 구현되어 있습니다.
- type_convert.asm : printf 포매팅 중에 타입 변환이 필요한 경우(정수 등) 사용되는 함수들이 구현되어 있습니다.