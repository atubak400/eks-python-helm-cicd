# Use official Python image as base
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy app files into the container
COPY app/ .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the app port
EXPOSE 5000

# Run the application
CMD ["python", "main.py"]
