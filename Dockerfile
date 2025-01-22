# Use Jupyter's base image for compatibility with MyBinder
FROM python:3.10.11-slim


# Copy requirements.txt into the container
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Register the custom kernel
RUN python -m ipykernel install --user --name=ml --display-name "Python (ML)"

# Create jovyan user and home directory
RUN useradd -m -s /bin/bash jovyan


# Set the working directory to the default for Jupyter
WORKDIR /home/jovyan

# Copy the rest of the application files into the container
COPY . /home/jovyan

# Debug step: List contents of /home/jovyan
RUN ls -la /home/jovyan

# Change ownership and permissions of the /home/jovyan directory
RUN chown -R jovyan:jovyan /home/jovyan && chmod -R 775 /home/jovyan

# Expose port 8888 for Jupyter
EXPOSE 8888

# Use the jovyan user (already set in base image)
USER jovyan

# Set the default command to run Jupyter Notebook
CMD ["/bin/bash", "-c", "exec jupyter lab --ip=0.0.0.0 --port=8888 --notebook-dir=/home/jovyan --no-browser --allow-root"]
