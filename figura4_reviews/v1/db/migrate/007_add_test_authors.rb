class AddTestAuthors < ActiveRecord::Migration
  def self.up
    author = Author.create(:first_name => "Frank",
                           :second_name => "Herbert",
                           :bio => "Frank Patrick Herbert nasce nel 1920 a Tacoma, nello stato di Washington. Pur non essendo un vero scienziato, studia attivamente Geologia Sottomarina, Psicologia, Antropologia, Ecologia, Navigazione e Botanica.\nInizia la carriera di scrittore di fantascienza nel 1952, su Startling Stories col racconto 'Looking for Something?', ottenendo subito attenzione ed apprezzamento da parte dei lettori.\nNei dieci anni successivi è corrispondente dalle maggiori città statunitensi della costa occidentale per l'Examiner di San Francisco, e continua a scrivere racconti.\nIl grande successo arriva nel 1963 col suo primo romanzo, 'Dune' (pubblicato inizialmente in due parti su Analog SF di John W. Campbell jr.) col quale l'autore dà vita all'omonimo e famoso ciclo, suggestivo affresco di un meraviglioso universo e di una civiltà futura, in cui dispiega al meglio tutte le sue qualità di studioso.\nFrank Herbert muore l'11 febbraio 1986 a Madison, nel Wisconsin.",
                           :picture => "frank_herbert.jpg")
                           
    author = Author.create(:first_name => "Ursula",
                           :second_name => "K. Le Guin",
                           :bio => "Ursula Kroeber Le Guin nasce a Berkeley (California) il 21 ottobre 1929, da Alfred L. Kroeber, autorità nel campo degli studi antropologici, e da Theodora K. Froeber. Si è imposta negli anni d'oro della fantascienza come tra le più geniali menti creatrici di mondi fantastici.\nAnarchica, femminista, pensatrice rara e profonda, è sicuramente la maggiore scrittrice vivente di fantascienza, avendo saputo rinnovare la letteratura di genere con una impronta stilistica e di contenuti molto personale e sempre superbamente poetica. I romanzi della Le Guin sono senza dubbio destinati a rimanere nella storia della letteratura americana, e non solo.",
                           :picture => "ursula_le_guin.jpg")    
  end

  def self.down
    Author.delete_all
  end

end
