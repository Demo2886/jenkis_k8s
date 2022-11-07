FROM python:3.8-alpine
RUN pip3 install --no-cache-dir pytest==7.2.0
COPY server.py /server.py
ENTRYPOINT ["python3","-u", "server.py"]
