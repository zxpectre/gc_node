CREATE INDEX IF NOT EXISTS idx_block_hash
    ON public.block(hash);

CREATE INDEX IF NOT EXISTS idx_multi_asset_name
    ON public.multi_asset(name);

CREATE INDEX IF NOT EXISTS idx_multi_asset_policy
    ON public.multi_asset(policy);

CREATE INDEX IF NOT EXISTS idx_reward_type
    ON public.reward(type);

CREATE INDEX IF NOT EXISTS idx_tx_hash
    ON public.tx(hash);

CREATE INDEX IF NOT EXISTS idx_tx_in_consuming_tx
   ON public.tx_in(tx_out_id);


