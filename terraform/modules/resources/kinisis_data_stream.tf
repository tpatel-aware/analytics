resource "aws_kinesis_stream" "kinesis_open" {
  name = "kinesis_open"
  #   shard_count must not be set when stream_mode is ON_DEMAND
  #   shard_count = 1
  retention_period    = 24 # in hours
  shard_level_metrics = ["IncomingBytes", "IncomingRecords"]
  stream_mode_details { stream_mode = "ON_DEMAND" }
  tags = {
    Name = "kinesis_open"
  }
}

