#!/bin/bash

docker build -t opencl:packager -f packager.Dockerfile .
docker build -t opencl:builder -f builder.Dockerfile .
docker build -t opencl:runtime -f runtime.Dockerfile .

