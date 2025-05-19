FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04

ENV PATH="/usr/local/cuda/bin:${PATH}"

RUN apt-get update && apt-get install -y \
    python3.10 python3-pip \
    build-essential cmake git ninja-build ffmpeg gdown \
    libgl1 unzip wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
    
# Clone source
# RUN git clone https://github.com/Phatdat01/stable_hair.git /app
# RUN gdown https://drive.google.com/uc?id=1GMSSZCb7j5WWd0pnmAcWp2H-Z-MeSIvO -O models.zip

# # Unzip models.zip and move extracted contents to /app/models
# RUN unzip models.zip -d /tmp/models && \
#     mkdir -p /app/models && \
#     cp -r /tmp/models/* /app/models && \
#     rm -rf /tmp/models models.zip
# Sao chép mã nguồn vào container

    
COPY ./stable_hair /app

RUN python3.10 -m pip install --upgrade pip
# Cài Python requirements
RUN pip3 install -r requirement.txt

# Cổng mặc định
EXPOSE 8986

# Lệnh khởi chạy
CMD ["python3", "gradio_demo_full.py"]