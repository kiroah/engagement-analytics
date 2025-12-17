from fastapi import APIRouter
from google.cloud import bigquery
import os

router = APIRouter()

# Client will be initialized lazily or we can initialize here if creds are present
# relying on ADC
try:
    client = bigquery.Client()
except Exception as e:
    print(f"Warning: BigQuery client could not be initialized. {e}")
    client = None

@router.get("/engagement_metrics")
def get_engagement_metrics():
    if not client:
        return {"error": "BigQuery client not initialized"}
    
    # Placeholder query - later we will use dbt models
    query = """
    SELECT "demo" as metric, 100 as value
    """
    try:
        query_job = client.query(query)
        results = [dict(row) for row in query_job]
        return {"data": results}
    except Exception as e:
        return {"error": str(e)}
