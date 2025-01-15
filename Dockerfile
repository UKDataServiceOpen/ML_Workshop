# Use the exact Python 3.10.11 slim image as the base image
FROM python:3.10.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt into the container
COPY requirements.txt .


# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Register the custom kernel
RUN python -m ipykernel install --user --name=ml --display-name "Python (ML)"

# Copy the rest of the application files into the container
COPY . .

# Expose port 8888 for Jupyter Notebook
EXPOSE 8888

# Set the default command to run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

