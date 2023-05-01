#!/bin/bash

function run_assembly {
    echo "*------- assembly (nasm) ---------*"
    nasm --version

    cd ./src
    nasm -f elf64 ./prime.asm
    ld -s -o prime prime.o
    cd ..

    sleep 5 # cpu cool down
    ./src/prime

    rm ./src/prime.o
    rm ./src/prime
}

function run_c_native {
    echo "*---- c native (opt-level=3) -----*"
    gcc --version | head -n 1
    gcc ./src/prime.c -o prime -lm -g -O3

    sleep 5 # cpu cool down

    ./prime
    rm ./prime
    echo ""
}

function run_cpp_native {
    echo "*--- c++ native (opt-level=3) ----*"
    g++ --version | head -n 1
    g++ ./src/prime.cpp -o prime -g -O3

    sleep 5 # cpu cool down

    ./prime
    rm ./prime
    echo ""
}

function run_rust_native {
    echo "*--- rust native (opt-level=3) ---*"
    rustc --version
    rustc -C opt-level=3 -C target-cpu=native -C codegen-units=1 -C lto ./src/prime.rs

    sleep 5 # cool down cpu

    ./prime
    rm ./prime
    echo ""
}

function run_go {
    echo "*-------------- go ---------------*"
    go version
    go build -ldflags "-s -w" ./src/prime.go

    sleep 5 # cpu cool down

    ./prime
    rm ./prime
    echo ""
    echo ""
}

function run_java {
    echo "*-------- java (open-jdk) --------*"
    javac --version
    javac ./src/Prime.java

    sleep 5 # cpu cool down

    cd src
    java Prime
    rm ./Prime.class
    cd ..
    echo ""
}

function run_nodejs {
    echo "*------------ nodejs -------------*"
    node --version

    sleep 5 # cool down cpu

    node ./src/prime.js
    echo ""
}

function run_csharp_mono {
    echo "*------------ c# Mono ------------*"
    mcs --version
    mcs ./src/prime.cs

    sleep 5 # cpu cool down

    mono ./src/prime.exe
    rm ./src/prime.exe
    echo ""
}

function run_dart_native {
    echo "*---------- dart native ----------*"
    dart --version
    dart compile exe ./src/prime.dart

    sleep 5 # cpu cool down

    ./src/prime.exe
    rm ./src/prime.exe
    echo ""
}

function run_python_codon {
    echo "*--------- python codon ----------*"
    codon --version
    codon build -release -exe ./src/prime.py

    sleep 5 # cpu cool down

    ./src/prime
    rm ./src/prime
    echo ""
}

function run_pascal {
    echo "*------------ pascal -------------*"
    fpc ./src/prime.pas

    sleep 5 # cpu cool down

    ./src/prime

    rm ./src/prime.o
    rm ./src/prime
    echo ""
}

function run_python {
    echo "*------------ python -------------*"
    python3 --version

    sleep 5 # cpu cool down

    python3 ./src/prime.py
    echo ""
}

function run_php {
    echo "*------------ Php -------------*"

    sleep 5 # cpu cool down

    php ./src/prime.php
    echo ""
}

function run_r {
    echo "*------------ R -------------*"

    sleep 5 # cpu cool down

    Rscript ./src/prime.R
    echo ""
}

function run_erlang {
    echo "*-------------- erlang ---------------*"
    erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell
    erlc -o src ./src/prime.erl
    erl -pa src -noshell -s prime main -s init stop

    rm ./src/prime.beam
    echo ""
}

if [ $# -eq 0 ]; then
    run_assembly
    run_c_native
    run_cpp_native
    run_rust_native
    run_go
    run_java
    run_nodejs
    run_csharp_mono
    run_dart_native
    run_python_codon
    run_pascal
    run_python
    run_php
    run_r
    run_erlang
else
    case $1 in
        "assembly" ) run_assembly ;;
        "c_native" ) run_c_native ;;
        "cpp_native" ) run_cpp_native ;;
        "rust_native" ) run_rust_native ;;
        "go" ) run_go ;;
        "java" ) run_java ;;
        "nodejs" ) run_nodejs ;;
        "csharp_mono" ) run_csharp_mono ;;
        "dart_native" ) run_dart_native ;;
        "python_codon" ) run_python_codon ;;
        "pascal" ) run_pascal ;;
        "python" ) run_python ;;
        "php" ) run_php ;;
        "r" ) run_r ;;
        "erlang" ) run_erlang ;;
        * ) echo "Invalid choice";;
    esac
fi
