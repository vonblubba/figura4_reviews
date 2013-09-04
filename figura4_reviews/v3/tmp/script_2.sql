/* autori */
DELETE FROM figura4_reviews_v3_production.authors;
INSERT INTO figura4_reviews_v3_production.authors
         (id,   second_name,   first_name,   bio,   bio_source, created_on,   updated_on)
 SELECT a.id, a.second_name, a.first_name, a.bio, l.link_url, a.created_on, a.updated_on
 FROM rivaoscar_db2.authors a LEFT JOIN rivaoscar_db2.links l
 ON a.id = l.author_id;

/* links globali */
DELETE FROM figura4_reviews_v3_production.links;
INSERT INTO figura4_reviews_v3_production.links
         (id,   page_title, description,   url)
 SELECT l.id, l.title,    l.description, l.link_url
 FROM rivaoscar_db2.links l
 WHERE l.in_link_section=1;

/* pictures */
CREATE TABLE IF NOT EXISTS figura4_reviews_v3_production.pictures LIKE rivaoscar_db2.pictures;
DELETE FROM figura4_reviews_v3_production.pictures;
INSERT INTO figura4_reviews_v3_production.pictures
         (id, name, content_type, type, data, user_id, review_id ,author_id, comment)
 SELECT p.id, p. name, p.content_type, p.type, p.data, p.user_id, p.review_id, p.author_id, p.comment  
 FROM rivaoscar_db2.pictures p; 

/* nodi */
/* fare l'update del titolo pagina e dei meta-tags!! */
DELETE FROM figura4_reviews_v3_production.nodes;
INSERT INTO figura4_reviews_v3_production.nodes
         (id, italian_title, italian_article, italian_subtitle,
		      original_title, original_article, original_subtitle,
			  pages, plot, review, year, editor, created_on, updated_on,
			  vote, type, language, author_id, published, user_id,
			  actors, nation, seasons)
 SELECT r.id, r.italian_title, r.italian_article, r.italian_subtitle,
		      r.original_title, r.original_article, r.original_subtitle,
			  r.pages, r.plot, r.review, r.year, r.editor, r.created_on, r.updated_on,
			  r.vote, r.type, r.language, r.author_id, r.published, r.user_id,
			  r.actors, r.nation, r.seasons 
 FROM rivaoscar_db2.reviews r;
 
/* commenti */
DELETE FROM figura4_reviews_v3_production.comments;
INSERT INTO figura4_reviews_v3_production.comments
         (id,   body,   user_id,   author,   email,   homepage,   created_on,   updated_on,     node_id,   is_spam,   user_ip,   user_agent,   referrer)
 SELECT c.id, c.body, c.user_id, c.author, c.email, l.link_url, c.created_on, c.updated_on, c.review_id, c.is_spam, c.user_ip, c.user_agent, c.referrer
 FROM rivaoscar_db2.comments c LEFT JOIN rivaoscar_db2.links l
 ON c.id = l.comment_id
 WHERE is_spam=0;
 
/* quotes */
DELETE FROM figura4_reviews_v3_production.quotes WHERE 1;
INSERT INTO figura4_reviews_v3_production.quotes
         (id, body, source, node_id, random)
 SELECT q.id, IF(CHAR_LENGTH(q.italian_text) > 0, q.italian_text, q.original_text),
        IF(CHAR_LENGTH(q.source) > 0, q.source, q.author) , q.review_id, random
 FROM rivaoscar_db2.quotes q;

/* taggings */
DROP TABLE figura4_reviews_v3_production.taggings;
CREATE TABLE figura4_reviews_v3_production.taggings LIKE rivaoscar_db2.taggings;
INSERT INTO figura4_reviews_v3_production.taggings
         (id, tag_id, taggable_id, taggable_type, created_at)
 SELECT t.id, t.tag_id, t.taggable_id, t.taggable_type, t.created_at   
 FROM rivaoscar_db2.taggings t;

/* tags */
DROP TABLE figura4_reviews_v3_production.tags;
CREATE TABLE figura4_reviews_v3_production.tags LIKE rivaoscar_db2.tags;
INSERT INTO figura4_reviews_v3_production.tags
         (id, name)
 SELECT t.id, t.name   
 FROM rivaoscar_db2.tags t;