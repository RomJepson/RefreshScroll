#!/bin/bash

# 初始化源目录和目标目录变量
FROM_DIR=${PROJECT_DIR}/${PROJECT_NAME}
TO_DIR=${PROJECT_DIR}/../../inc/${PROJECT_NAME}

# 确认目标目录存在
if [ ! -d ${TO_DIR} ]; then
    mkdir -p ${TO_DIR}
fi

# 更新头文件
rm -rf ${TO_DIR}/*
cp -R ${FROM_DIR}/* ${TO_DIR}/
rm -f `find ${TO_DIR} -name "*.m"`
rm -f `find ${TO_DIR} -name "*.pch"`

# 清除多余头文件
rm -rf ${PROJECT_DIR}/../../lib/${PLATFORM_NAME}/include