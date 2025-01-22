# Use the exact Python 3.10.11 slim image as the base image
FROM python:3.10.11-slim

# Set the working directory to Binder's default
WORKDIR /home/jovyan

# Copy requirements.txt into the container
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Register the custom kernel
RUN python -m ipykernel install --user --name=ml --display-name "Python (ML)"

# Copy the rest of the application files into the container
COPY . /home/jovyan

# Set permissions for the working directory
RUN chown -R jovyan:jovyan /home/jovyan && chmod -R 775 /home/jovyan

# Switch to the jovyan user
USER jovyan

# Expose port 8888 for Jupyter Notebook
EXPOSE 8888

# Set the default command to run JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--notebook-dir=/home/jovyan", "--ServerApp.base_url=/binder/jupyter", "--NotebookApp.shutdown_no_activity_timeout=3600"]

