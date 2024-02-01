
ALTER TABLE IF EXISTS public.ma_tx_mint
    ADD FOREIGN KEY (tx_id)
    REFERENCES public.tx (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.ma_tx_mint
    ADD FOREIGN KEY (ident)
    REFERENCES public.multi_asset (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.ma_tx_mint
    ADD FOREIGN KEY (tx_id)
    REFERENCES public.tx (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.ma_tx_out
    ADD CONSTRAINT ma_tx_out_tx_out_id_fkey FOREIGN KEY (tx_out_id)
    REFERENCES public.tx_out (id) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS idx_ma_tx_out_tx_out_id
    ON public.ma_tx_out(tx_out_id);


ALTER TABLE IF EXISTS public.tx
    ADD FOREIGN KEY (block_id)
    REFERENCES public.block (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;