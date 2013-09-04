class AddTestReviews < ActiveRecord::Migration
  def self.up
    review = Review.create(:italian_title => "Dune" ,
                           :italian_article => nil,
                           :original_title => "Dune",
                           :original_article => nil,
                           :pages => 500,
                           :plot => "Arrakis, meglio conosciuto come Dune, è l’unico pianeta dell’universo su cui si trova il melange, la spezia, la sostanza su cui si basa l’intera economia dell’impero. La spezia allunga la vita, dona capacità di preveggenza, e soprattutto rende possibili i viaggi interstellari. Arrakis tuttavia è un pianeta desertico, abitato solo dagli indigeni Fremen e dai vermi delle sabbie, enormi creature che vengono attirate da qualsiasi vibrazione del terreno. La raccolta della spezia è quindi un affare molto rischioso, ma anche molto redditizio. L’incarico di raccogliere la preziosa sostanza viene affidato dall’imperatore alla nobile casa Atreides. Ma quella che sembra essere un’ottima occasione potrebbe nascondere un complotto per annientare casa Atreides, organizzato dai rivali Harkonnen, con la complicità dell’imperatore stesso.",
                           :review => "Dune è sicuramente una delle più importanti opere di SF di tutti i tempi; l’universo ricreato da Herbert non ha eguali per realismo e dettaglio della rappresentazione. In particolare la struttura sociale e l’ecosistema di Arrakis vengono delineati con un realismo incredibile; il modo di vivere dei Fremen, il culto dell’acqua e del dio-verme Shai-Hulud, la loro esistenza in simbiosi con l’inospitale ambiente circostante fanno da contorno ad una trama avvincente e ben congegnata.\nDune è il primo libro di una saga di 6 romanzi (interrotta purtroppo con la scomparsa dell’autore), e tra questi è probabilmente il più significativo. Da Dune è stato inoltre tratto il film omonimo di David Lynch del 1984.",
                           :year => "1963",
                           :editor => "Editrice Nord",
                           :language => 0,
                           :cover => "dune.jpg",
                           :vote => 10,
                           :media => 1,
                           :final_words => "Capolavoro",
                           :published => 1, 
                           :user_id => 1,
                           :reason_to_read => "Ambientazione: in tutta la letteratura fantastica, solo Tolkien riesce a creare un mondo altrettanto vivo, realistico, credibile  e dettagliato.",
                           :reason_to_avoid => "Se trovate qualcosa che non va in questo romanzo, fatemelo sapere...")

    review.author = Author.find_by_second_name("Herbert")
    review.user = User.find(:first)
    review.save

    review = Review.create(:italian_title => "reietti dell'altro pianeta" ,
                           :italian_article => "I",
                           :original_title => "Dispossessed",
                           :original_article => "The",
                           :pages => 400,
                           :review => "La Le Guin qui tenta qualcosa di molto simile a quanto aveva tentato in 'La mano sinistra delle tenebre': prendere la nostra società, eliminare completamente uno dei suoi elementi costitutivi e cercare di immaginare cosa potrebbe risultarne. In 'La mano sinistra delle tenebre' l'elemento era la distinzione tra i sessi; qui si tratta dei concetto di proprietà e di governo. Ancora una volta il risultato è eccellente; sebbene la struttura sociale di Anarres (priva di governo e di leggi) risulti un pochino nebulosa e nel complesso del tutto utopica ed irrealizzabile (e lo dico con grande amarezza...), le riflessioni che vengono proposte attraverso gli occhi del protagonista Shevek sono ancora più stimolanti di quanto non accadesse in 'La mano sinistra delle tenebre'. L'apoteosi è probabilmete rappresentata dal dialogo finale tra Shevek e l'ambasciatrice terrestre, davvero notevole.\nSi tratta però di un romanzo profondamente introspettivo, che non si limita ad analizzare asetticamente le differenze tra due società antitetiche, ma racconta prima di tutto il dilemma che si combatte nell'animo del protagonista. Ed è in questo che la Le Guin eccelle in tutti gli aspetti.\n\nAnche la scelta narrativa è interessante e decisamente azzeccata: la narrazione procede su due binari paralleli, che si sviluppano a distanza di alcune decine di anni l'uno dall'altro; in uno vediamo l'adolescenza di Shevek e la catena di eventi che lo portano alla decisione di recarsi su Urras; nell'altro assistiamo al suo arrivo su Urras e a tutti gli avvenimenti che ne seguono. Questa scelta si rivela sempre più azzeccata con il procedere della storia, fino ad arrvare al finale, che vede la partenza di Shevek da Anarres nel primo filone, ed il suo ritorno nel secondo, eveti narrati in due capitoli consecutivi del romanzo, conferendo quel senso di compiutezza, di circolo che si chiude.\n\nCon 'The dispossessed' e 'La mano sinsitra delle tenebre', la Le Guin finisce dritta dritta tra i miei 5 autori preferiti, ed ho tutta l'impressione che ci resterà per parecchio tempo... ",
                           :plot => "Anarres e Urras: due pianeti gemelli,ma diversi come la luce e l'ombra. Urras è un pianeta ricco, il suo territorio è diviso in innumerevoli nazioni costantemente in lotta, lo scopo dei suoi abitanti accumulare ricchezza. Anarres è una colonia fondata da un gruppo di ribelli anarchici, che hanno abbandonato Urras in seguito ad una rivolta. Questi ribelli tentano di costruire la loro società ideale: nessun governo che limiti la libertà degli individui, il concetto di proprietà abolito. Le condizioni di vita sono ardue perchè Anarres è un pianeta desertico ed inospitale. Tutti devono contribuire alla sopravvivenza della comunità, in una condizione di totale uguaglianza tra gli individui.\nSu Anarres vive Shevek, un brillante fisico che sembra essere destinato a formulare una teoria che potrebbe rivoluzionare il modo di concepire i viaggi interstellari. Eppure la comunità scientifica di Anarres non sembra interessata al suo lavoro; la società di Anarres è ermeticamente chiusa in sè stessa, evita in ogni modo il contatto con l'esterno per evitare di essere contaminata dai valori capitalistici: i viaggi interstellari non rappresentano una priorità. Shevek allora decide di lasciare Anarres e recarsi su Urras, nella speranza di poter portare a termine il suo lavoro in luogo dove esso possa essere apprezzato; ma nel suo cuore egli cova anche la speranza di poter costruire un ponte tra Urras ed Anarres, da troppo tempo divisi e apparentemente senza alcuna speranza di riconcilazione.\nArrivato su Urras, Shevek dovrà conrontarsi con una realtà dai valori etici e morali diametralmente opposti ai suoi, e comincia a dubitare che Urras sia il luogo giusto dove portare avanti le sue rierche, amesso che tale luogo possa davvero esistere...",
                           :year => "1975",
                           :editor => "eos",
                           :language => 0,
                           :cover => "dispossessed.jpg",
                           :vote => 10,
                           :media => true,
                           :final_words => "",
                           :published => true, 
                           :user_id => 1)

    review.author = Author.find_by_second_name("K. Le Guin")
    review.user = User.find(:first)
    review.save

  end

  def self.down
    Review.delete_all
  end
end
