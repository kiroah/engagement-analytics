import streamlit as st
import requests
import pandas as pd
import plotly.express as px

st.set_page_config(page_title="(DEMO APP) Engagement Analytics", layout="wide")

st.title("(DEMO APP) Engagement Analytics Dashboard")

API_URL = "http://localhost:8000/api/v1"

st.sidebar.header("Controls")

if st.button("Load Data"):
    try:
        response = requests.get(f"{API_URL}/engagement_metrics")
        if response.status_code == 200:
            data = response.json().get("data", [])
            if data:
                df = pd.DataFrame(data)
                st.dataframe(df)
                
                
                if 'metric' in df.columns and 'value' in df.columns:
                    fig = px.bar(df, x='metric', y='value', title="Demo Metric")
                    st.plotly_chart(fig)
            else:
                st.info("No data returned")
        else:
            st.error(f"Error fetching data: {response.text}")
    except Exception as e:
        st.error(f"Connection error: {e}")

st.markdown("---")
st.caption("MVP Setup")
