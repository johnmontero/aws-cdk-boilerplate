import os
from aws_cdk import core
from aws_cdk import aws_s3 as s3


class AppStack(core.Stack):

    def __init__(self, scope: core.Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)
        
        # The code that defines your stack goes here
        env = os.getenv('ENV')
        bucket = s3.Bucket(self, 
            f"cdn.{env}.app.stack", bucket_name=f"cdn.{env}.app.stack", versioned=True,)
