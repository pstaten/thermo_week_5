# Thanks ChatGPT for helping me with this

# Use an official Continuum Analytics Docker image that includes Conda
FROM continuumio/miniconda3:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the environment.yml file into the container
COPY environment.yml /app/environment.yml

# Create the conda environment from the environment.yml file
RUN conda env create -f environment.yml

# Make sure the environment is activated when the container starts
SHELL ["conda", "run", "-n", "base", "/bin/bash", "-c"]

# Update PATH so that conda and the environment are accessible
ENV PATH /opt/conda/envs/base/bin:$PATH

# Copy the rest of the application code into the container
COPY . /app

# Set the default command to run Jupyter Notebook (or replace with your main script)
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
