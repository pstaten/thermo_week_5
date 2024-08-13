# Thanks ChatGPT for helping me with this

# Use an official Continuum Analytics Docker image that includes Conda
# FROM continuumio/miniconda3:latest
FROM continuumio/miniconda3:4.9.2

# Set the working directory inside the container
WORKDIR /app

# Copy the environment.yml file into the container
COPY environment.yml /app/environment.yml

# install mamba, which will hopefully work without crashing docker
RUN conda install -c conda-forge mamba -n base

# Create the conda environment from the environment.yml file
RUN  mamba env create -f environment.yml --verbose


# Make sure the environment is activated when the container starts
SHELL ["conda", "run", "-n", "my-custom-env", "/bin/bash", "-c"]

# Update PATH so that conda and the environment are accessible
ENV PATH=/opt/conda/envs/my-custom-env/bin:$PATH

# Copy the rest of the application code into the container
COPY . /app

# Expose the port used by Jupyter Notebook
EXPOSE 8888

# Set the default command to run Jupyter Notebook (or replace with your main script)
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
