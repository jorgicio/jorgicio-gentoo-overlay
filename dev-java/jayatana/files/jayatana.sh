if [ -n "$JAVA_TOOL_OPTIONS" ]; then
    JAVA_TOOL_OPTIONS="-javaagent:/usr/share/java/jayatanaag.jar ${JAVA_TOOL_OPTIONS}"
else
    JAVA_TOOL_OPTIONS="-javaagent:/usr/share/java/jayatanaag.jar"
fi

export JAVA_TOOL_OPTIONS
