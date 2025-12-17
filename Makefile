.PHONY: help install run-backend run-frontend dbt-run dbt-debug

help:
	@echo "Available commands:"
	@echo "  make install       - Install dependencies in venv"
	@echo "  make run-backend   - Run FastAPI backend"
	@echo "  make run-frontend  - Run Streamlit frontend"
	@echo "  make dbt-run       - Run dbt models"
	@echo "  make dbt-debug     - Debug dbt connection"

install:
	python3 -m venv venv
	. venv/bin/activate && pip install -r backend/requirements.txt
	. venv/bin/activate && pip install -r frontend/requirements.txt
	. venv/bin/activate && pip install dbt-bigquery

run-backend:
	. venv/bin/activate && export PYTHONPATH=$$PYTHONPATH:. && uvicorn backend.main:app --reload --port 8000

run-frontend:
	. venv/bin/activate && streamlit run frontend/app.py --server.port 8501

dbt-run:
	. venv/bin/activate && cd dbt && dbt run

dbt-debug:
	. venv/bin/activate && cd dbt && dbt debug
