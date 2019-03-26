#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

set -e
set -u

export PYTHONPATH=nnvm/python:python:topi/python
export PYTHONPATH=$PYTHONPATH:.local/lib/python3.6/site-packages

# to avoid openblas threading error
export OMP_NUM_THREADS=1

# Rebuild cython
make cython
make cython3

echo "Running relay TFLite frontend test..."
python3 -m nose -v tests/python/frontend/tflite

echo "Running nnvm unittest..."
python -m nose -v nnvm/tests/python/unittest
python3 -m nose -v nnvm/tests/python/unittest

echo "Running nnvm compiler test..."
python3 -m nose -v nnvm/tests/python/compiler

echo "Running nnvm ONNX frontend test..."
python3 -m nose -v nnvm/tests/python/frontend/onnx

echo "Running nnvm MXNet frontend test..."
python3 -m nose -v nnvm/tests/python/frontend/mxnet

echo "Running nnvm Keras frontend test..."
python3 -m nose -v nnvm/tests/python/frontend/keras

echo "Running nnvm Tensorflow frontend test..."
python3 -m nose -v nnvm/tests/python/frontend/tensorflow

echo "Running nnvm CoreML frontend test..."
python3 -m nose -v nnvm/tests/python/frontend/coreml

echo "Running nnvm DarkNet frontend test..."
python3 -m nose -v nnvm/tests/python/frontend/darknet || exit -1

echo "Running relay MXNet frontend test..."
python3 -m nose -v tests/python/frontend/mxnet

echo "Running relay Keras frontend test..."
python3 -m nose -v tests/python/frontend/keras

echo "Running relay ONNX frondend test..."
python3 -m nose -v tests/python/frontend/onnx

echo "Running relay CoreML frondend test..."
python3 -m nose -v tests/python/frontend/coreml

echo "Running nnvm to relay frontend test..."
python3 -m nose -v tests/python/frontend/nnvm_to_relay

echo "Running relay Tensorflow frontend test..."
python3 -m nose -v tests/python/frontend/tensorflow

echo "Running relay caffe2 frondend test..."
python3 -m nose -v tests/python/frontend/caffe2

echo "Running nnvm PyTorch frontend test..."
python3 -m nose -v tests/python/frontend/pytorch
