FROM python:3.8-alpine
RUN pip3 install --no-cache-dir pytest
COPY server.py /server.py
ENTRYPOINT ["python3","-u", "server.py"]
