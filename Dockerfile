FROM continuumio/anaconda3:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY environment.yml .
RUN conda env create -f environment.yml
RUN echo "source activate conda_env" >> ~/.bashrc
ENV PATH /opt/conda/envs/conda_env/bin:$PATH

# Copy the rest of the application code into the container at /app
COPY . .

# Set the environment variable to tell Flask where to find the app
ENV FLASK_APP=app.py

# Expose port 5000 for the Flask app to listen on
EXPOSE 5000

# Start the Flask app
CMD ["flask", "run", "--host", "0.0.0.0"]
