--product rating
CREATE OR REPLACE FUNCTION product_rating()
RETURNS TRIGGER AS $$
BEGIN 
    IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN
        UPDATE business.product
        SET rating = (SELECT AVG(score) FROM business.review WHERE product_id = NEW.product_id)
        WHERE id = NEW.product_id;
    ELSEIF (TG_OP = 'DELETE') THEN
        UPDATE business.product
        SET rating = (SELECT AVG(score) FROM business.review WHERE product_id = OLD.product_id)
        WHERE id = OLD.product_id;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER product_rating_trigger
AFTER INSERT OR UPDATE OR DELETE ON business.review
FOR EACH ROW
EXECUTE FUNCTION product_rating();

--customer point
CREATE OR REPLACE FUNCTION customer_point()
RETURNS TRIGGER AS $$
BEGIN

    IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN
        UPDATE usertable.customer
        SET point = point + FLOOR(NEW.total_charge)
        WHERE id = NEW.customer_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER customer_point_trigger
AFTER INSERT OR UPDATE ON business._order
FOR EACH ROW
EXECUTE FUNCTION customer_point();

--gift exchange
CREATE OR REPLACE FUNCTION gift_exchange()
RETURNS TRIGGER AS $$
BEGIN 
    IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN
        UPDATE usertable.customer
        SET point = point - (NEW.quantity * (SELECT point FROM business.gift WHERE id = NEW.gift_ID))
        WHERE id = NEW.customer_ID;
    ELSEIF (TG_OP = 'DELETE') THEN
        UPDATE usertable.customer
        SET point = point + (OLD.quantity * (SELECT point FROM business.gift WHERE id = OLD.gift_ID))
        WHERE id = OLD.customer_ID;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER gift_exchange_trigger
AFTER INSERT OR UPDATE OR DELETE ON business.exchange
FOR EACH ROW
EXECUTE FUNCTION gift_exchange();
