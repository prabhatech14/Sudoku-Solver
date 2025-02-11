FROM python:latest

MAINTAINER prabha

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8080

CMD [ "python3", "SudokuGUI.py"]

