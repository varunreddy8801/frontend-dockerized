#!/bin/sh

# Source port configuration functions
. /port-config.sh

if [ -f "package.json" ]; then
    npm install

    # Get framework type and port
    FRAMEWORK_INFO=$(detect_framework_and_port)
    FRAMEWORK_TYPE=$(get_framework_name)
    FRAMEWORK_PORT=$(get_framework_port)

    echo "Detected framework: $FRAMEWORK_TYPE (default port: $FRAMEWORK_PORT)"

    # Run appropriate dev command based on framework
    if [ "$#" -eq 0 ]; then
        case $FRAMEWORK_TYPE in
            "next")
                echo "Starting Next.js development server on port $FRAMEWORK_PORT"
                npm run dev -- -p $FRAMEWORK_PORT
                ;;
            "expo")
                echo "Starting Expo development server on port $FRAMEWORK_PORT"
                npm run web -- --port $FRAMEWORK_PORT
                ;;
            "react"|"vue"|"vite")
                echo "Starting $FRAMEWORK_TYPE development server on port $FRAMEWORK_PORT"
                npm run dev -- --host --port $FRAMEWORK_PORT
                ;;
            *)
                echo "Unknown framework type, starting development server on port $FRAMEWORK_PORT"
                npm run dev -- --host --port $FRAMEWORK_PORT
                ;;
        esac
    else
        # If arguments are provided, execute them instead
        $@
    fi
else
    # If no package.json, just execute provided arguments
    $@
fi
