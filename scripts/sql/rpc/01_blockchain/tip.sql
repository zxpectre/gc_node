CREATE OR REPLACE FUNCTION {{SCHEMA}}.tip()
RETURNS TABLE (
  hash text,
  epoch_no word31type,
  abs_slot word63type,
  epoch_slot word31type,
  block_no word31type,
  block_time integer
)
LANGUAGE sql STABLE
AS $$
  SELECT
    ENCODE(b.hash::bytea, 'hex') AS block_hash,
    b.epoch_no AS epoch_no,
    b.slot_no AS abs_slot,
    b.epoch_slot_no AS epoch_slot,
    b.block_no,
    EXTRACT(EPOCH FROM b.time)::integer
  FROM block AS b
  ORDER BY b.id DESC
  LIMIT 1;
$$;

COMMENT ON FUNCTION {{SCHEMA}}.tip IS 'Get the tip info about the latest block seen by chain'; -- noqa: LT01
