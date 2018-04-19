class BoardCase
  #TO DO : la classe a 2 attr_accessor, sa valeur (X, O, ou vide), ainsi que son numéro de case)
attr_accessor :value

  def initialize(value = " ")
    #TO DO doit régler sa valeur, ainsi que son numéro de case
    @value = value
  end
  
  def to_s
    #TO DO : doit renvoyer la valeur au format string
    return @value.to_s
  end

end


class Board
  include Enumerable
  #TO DO : la classe a 1 attr_accessor, une array qui contient les BoardCases
  attr_accessor :tab

  @@count = 1

  def initialize
  #TO DO :
  #Quand la classe s'initialize, elle doit créer 9 instances BoardCases
  #Ces instances sont rangées dans une array qui est l'attr_accessor de la classe
    @a1 = BoardCase.new
    @a2 = BoardCase.new
    @a3 = BoardCase.new
    @b1 = BoardCase.new
    @b2 = BoardCase.new
    @b3 = BoardCase.new
    @c1 = BoardCase.new
    @c2 = BoardCase.new
    @c3 = BoardCase.new
  end


  def win_combos 
  #array de 8 sous-arrays qui sont les combinaisons gagnantes
    [[@a1.value, @a2.value, @a3.value],
    [@a1.value, @b2.value, @c3.value],
    [@a1.value, @b1.value, @c1.value],
    [@b1.value, @b2.value, @b3.value],
    [@c1.value, @c2.value, @c3.value],
    [@c1.value, @b2.value, @a3.value],
    [@a2.value, @b2.value, @c2.value],
    [@a3.value, @b3.value, @c3.value]]
  end

  def victory? 
  #méthode vérifiant si une des combinaisons gagnantes a été obtenue
    win_combos.each do |combos| 
    if combos[0] == "X" && combos[1] == "X" && combos[2] == "X"
      print_grid
      puts "Le joueur 1 gagne. Félicitations!"
      exit 
    elsif combos[0] == "O" && combos[1] == "O" && combos[2] == "O"
      print_grid
      puts "Le joueur 2 gagne. Félicitations!"
      exit
    
    end
  end
end

  def print_grid
  #TO DO : afficher le plateau
    puts
    puts "   1   2   3"
    puts "A  #{@a1} | #{@a2} | #{@a3} " 
    puts "  ---|---|---"
    puts "B  #{@b1} | #{@b2} | #{@b3} "
    puts "  ---|---|---"
    puts "C  #{@c1} | #{@c2} | #{@c3} "
    puts
  end


  def player_one
    # méthode qui change la BoardCase jouée en fonction de la valeur du joueur 1 (X)
    print_grid
    puts "joueur 1 choisis une case:"
    input = gets.chomp.downcase
    case input 
      when "a1" 
        @a1.value = "X"
      when "a2" 
        @a2.value = "X"
      when "a3" 
        @a3.value = "X"
      when "b1" 
        @b1.value = "X"
      when "b2" 
        @b2.value = "X"
      when "b3" 
        @b3.value = "X"
      when "c1" 
        @c1.value = "X"
      when "c2" 
        @c2.value = "X"
      when "c3" 
        @c3.value = "X"
      else puts "mauvaise case, essaye encore"
        player_one
      end
    victory? # on vérifie si une combinaison gagnante a été obtenue
    @@count += 1
    if @@count <= 9
    player_two # on passe au joueur 2
  else 
    print_grid
    puts "Egalité!"
  end
end

  def player_two
    # méthode qui change la BoardCase jouée en fonction de la valeur du joueur 2 (O)
    print_grid
    puts "joueur 2 choisis une case:"
    input = gets.chomp.downcase
    case input 
      when "a1" 
        @a1.value = "O"
      when "a2" 
        @a2.value = "O"
      when "a3" 
        @a3.value = "O"
      when "b1" 
        @b1.value = "O"
      when "b2" 
        @b2.value = "O"
      when "b3" 
        @b3.value = "O"
      when "c1" 
        @c1.value = "O"
      when "c2" 
        @c2.value = "O"
      when "c3" 
        @c3.value = "O"
      else puts "mauvaise case, essaye encore"
        player_two
      end
    victory? # on vérifie si une combinaison gagnate a été obtenue
    @@count += 1
    if @@count <= 9
    player_one # on repasse au joueur 1
  else
    print_grid
    puts "Egalité!"
  end
end

end


class Player
  #TO DO : la classe a 2 attr_accessor, son nom, sa valeur (X ou O). Elle a un attr_writer : il a gagné ?
  attr_accessor :name, :team
  attr_writer :result
  
  def initialize(name)
    @name = name
    @team = team
    #@result = result
  end

  def to_s
    #TO DO : doit renvoyer la valeur au format string
    return @name.to_s
  end
end


class Game
  def initialize
    #TO DO : créé 2 joueurs, créé un board
    puts "Bienvenue au jeu du Morpion !"
    sleep(1)
    puts "Joueur 1, quel est ton prénom ?"
    @name1 = gets.chomp
    puts "Joueur 2, quel est ton prénom ?"
    @name2 = gets.chomp
    puts @name1 + " joue avec X, " + @name2 + " joue avec O"
    puts "Pour placer ton X ou ton O sur la grille, tape sa position (par exemple : a1,...)."
    puts "Pour quitter, taper Ctrl + c"
    @player1 = Player.new(@name1)
    @player2 = Player.new(@name2)
    @grid = Board.new
  end

  def go
  @grid.player_one

  end

end

Game.new.go