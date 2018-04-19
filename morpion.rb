#Création d'une classe Boardcase qui contiendra 9 instances pour représenter les cases de la grille.
class BoardCase
#Chaque instante aura un attr_accessor représentant sa valeur, vide, X ou O
attr_accessor :value

	#Méthode d'initialisation de la classe
  def initialize(value = " ")
    @value = value
  end
  
  #retourne la valeur (vide, X ou O) de l'instance
  def to_s
    return @value.to_s
  end

end


#Création d'une classe Board qui représente la grille de jeu et qui renvoie vers l'initialisation de ses 9 cases
class Board
  include Enumerable
  #l'unique instance du tableau a pour attribut un tableau qui contient 9 instances de la classe BoardCase, soit ses 9 cases
  attr_accessor :tab
  #variable de classe qui compte le nombre de tour effectués et permet de limiter à 9 tours
  @@count = 1

  def initialize
  #Méthode d'initialistion de la classe Board qui renvoie vers l'initialisation de 9 cases de jeu
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
  #Modélisation des combinaisons (combos) gagnantes sous la forme de 8 arrays
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
  #Méthode qui affiche l'état actuel de la grille
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
    # Méthode qui change la valeur ("", 0 ou X) de la BoardCase en fonction du choix du joueur qui a les X pour refléter sont coup
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
    puts "Egalité!"	#Cas où les 9 coups ont été joués sans qu'il n'y ait de vainqueur
  end
end

  def player_two
    # # Méthode qui change la valeur ("", 0 ou X) de la BoardCase en fonction du choix du joueur qui a les 0 pour refléter sont coup
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
    print_grid #Cas où les 9 coups ont été joués sans qu'il n'y ait de vainqueur
    puts "Egalité!"
  end
end

end

#création d'une méthode Player qui dénifie les deux jours de la partie (ses instances)
class Player
 #Chaque joueur aura pour attibut un nom et une équipe (X ou 0)
  attr_accessor :name, :team
  
  #Méthode d'initialisation de la classe Player  
  def initialize(name)
    @name = name
    @team = team

  end

  #Méthode qui envoie le nom du joueur de la classe player
  def to_s
    return @name.to_s
  end
end


#Création d'une classe game qui représente le déroulement du jeu
class Game
	#Méthode qui initialise la classe Game en demandant les prénoms des joueurs, en déterminant les équipes de chacun
	#puis donne les consignes et lance l'initialisation de deux instances (joueurs) de la classe Player
  def initialize
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
  #Méthode qui lance le premier tour de la partie
  def go
  @grid.player_one

  end

end

Game.new.go