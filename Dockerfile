# Use Jupyter's base image for compatibility with MyBinder
FROM jupyter/base-notebook:python-3.10.11

# Set the working directory to the default for Jupyter
WORKDIR /home/jovyan

# Copy requirements.txt into the container
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Register the custom kernel
RUN python -m ipykernel install --user --name=ml --display-name "Python (ML)"

# Create the notebook directory (redundant but explicit)
RUN mkdir -p /home/jovyan

# Copy the rest of the application files into the container
COPY . /home/jovyan

# Ensure jovyan owns the working directory
RUN chown -R jovyan:jovyan /home/jovyan

# Expose port 8888 for Jupyter
EXPOSE 8888

# Use the jovyan user (already set in base image)
USER jovyan

# Set the default command to run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--notebook-dir=/home/jovyan", "--NotebookApp.shutdown_no_activity_timeout=3600"]
