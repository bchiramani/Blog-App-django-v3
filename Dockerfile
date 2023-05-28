# Use an official Python runtime as the base image
FROM python:3.9

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /code

# Install Conda
RUN apt-get update && \
    apt-get install -y curl && \
    curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    /opt/conda/bin/conda init && \
    echo "conda activate" >> ~/.bashrc

# Copy environment.yml file and create Conda environment
COPY environment.yml /code/environment.yml
RUN /opt/conda/bin/conda env create -f environment.yml

# Activate Conda environment
SHELL ["conda", "run", "-n", "blog", "/bin/bash", "-c"]

# Copy project files
COPY . /code/

# Set the entry point to run the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
