# 🤝 Contributing to Frontent Dockerized

Thank you for your interest in contributing to Frontent Dockerized! Here's how you can help:

## Setup for Contributing

1. **Fork the repository**
2. **Create your feature branch:**

   ```bash
   git checkout -b feature/amazing-feature
   ```

3. **Make your changes**
4. **Test your changes thoroughly**
5. **Commit your changes:**

   ```bash
   git commit -m 'Add some amazing feature'
   ```

6. **Push to the branch:**

   ```bash
   git push origin feature/amazing-feature
   ```

7. **Open a Pull Request**

8. **Wait for review**: Maintainers will review and provide feedback

9. **Address feedback**: Make requested changes and push updates

10. **Merge**: Once approved, your PR will be merged!

## Areas for Contribution

- 🎨 **New Framework Support** - Add detection and configuration for additional frameworks
- 🐛 **Bug Fixes** - Help fix any issues or improve error handling
- 📚 **Documentation** - Improve documentation and examples
- 🚀 **Performance** - Optimize build times and container performance

## Adding New Framework Support

To add support for a new framework:

1. **Update `docker/detect-framework.sh`:**

   ```bash
   elif grep -q '"your-framework"' "$PROJECT_DIR/package.json"; then
       FRAMEWORK="your-framework"
       DETECTED_PORT="your-port"
   ```

2. **Update `docker/port-config.sh`:**

   ```bash
   elif grep -q '"your-framework"' package.json; then
       echo "your-framework:your-port"
   ```

3. **Update `docker/entrypoint.sh`:**

   ```bash
   "your-framework")
       echo "Starting your-framework development server on port $FRAMEWORK_PORT"
       npm run <your-run-command> -- --port $FRAMEWORK_PORT
       ;;
   ```

4. **Add initialization command to Makefile:**

   ```makefile
   init-<your-framework>:  ## Initialize a new Your Framework App
       @make init-framework CREATE_COMMAND="npx create-your-framework@latest ${PROJECT_NAME}"
   ```

5. **Update documentation and examples**

## Code Style

- Use consistent shell scripting practices
- Follow Makefile conventions
- Update documentation for any new features
- Test with multiple frameworks before submitting
