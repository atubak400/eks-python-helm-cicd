# Use official Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ .

# Expose port 80 to match the app and Kubernetes Service
EXPOSE 80

# Command to run app
CMD ["python", "main.py"]
