import re
import pandas as pd
import os
from google.cloud import vision

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


# Load environment variables from the .env file
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/src/personal-gcp.json'

def detect_text_uri(uri):
    """Detects text in the file located in Google Cloud Storage or on the Web."""

    client = vision.ImageAnnotatorClient()
    image = vision.Image()
    image.source.image_uri = uri

    response = client.text_detection(image=image)
    if response.error.message:
        raise Exception(
            "{}\nFor more info on error messages, check: "
            "https://cloud.google.com/apis/design/errors".format(response.error.message)
        )
    else:
        texts = response.text_annotations

    overall = [text.description for text in texts][0]

    keys = ["food_drink", "home_health", "clothes_beauty", "entertainment", "transport", "other"]
    values = [float(item.lstrip('$')) for sublist in [x.split(' ') for x in overall.split('\n')[1:-2] if re.compile(r'.*\d+.*').match(x)] for item in sublist]

    return {key: value for key, value in zip(keys, values)}


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your transformation logic here
    df = pd.concat([
        data, 
        data['png_url'].apply(detect_text_uri).apply(pd.Series)
        ], axis=1)
    
    return df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
