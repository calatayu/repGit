use strict;
use warnings;
use strict;
use GD::Graph::bars;
use Term::ANSIColor;
print color 'bold green';

print "\f\tProjet de Perl\tLAMY Léo\f\n";
print color 'reset';
print color 'blue';
#ouverture de notre liste de séquence
open (F1,"fragments1000.faa")or die("pb chargement fragments1000.faa\n");

#on concatène tout notre fichier dans $text
my $text="";
while (my$li=<F1>){
	$text=$text.$li; 
}
close (F1);
#je vais chercher mes clones et je garde en mémoire dans un hash chaque séquence avec (numero de sequence.debut|fin) en clé
my %sequence;
while ($text=~m/^>clone(\d+)_(\w+)\s+(\w+)/gm){
	$sequence{$1.$2}=$3;
}

#je me sert du nombre de clé pour déterminer nombre de séquence
my@cle=keys(%sequence);
my$nombre_de_sequence = scalar(@cle);
print ("I.1 Le nombre de séquence est : $nombre_de_sequence séquences.\n");
################################################################
#taille des fragents dans un tableau en parcourant mon hash
my@taille_fragment;

foreach my$clec(@cle){
	my@seqcourante=split ("",$sequence{$clec});
	#on garde en mémoire la taille des fragments
	push(@taille_fragment,scalar(@seqcourante));
	}

my$moyenne_des_longueurs_des_fragments=&moyenne(@taille_fragment);
my$ecarttypelongueur=&ecart_type(@taille_fragment);
print("I.2 La moyenne des longueurs des fragments est de $moyenne_des_longueurs_des_fragments nucléotides (écart-type :$ecarttypelongueur).\n");

################################################################
#on cherche des nuc différentes de ATCG
my %autre_nuc;
foreach my$clec(@cle){
	my$seqc=$sequence{$clec};
	while ($seqc=~ m/([^atgc])/gi){
		$autre_nuc{$1}++;
	}
}
#je lis mon hash %autre_nuc
my@cle_autre_nuc=keys(%autre_nuc);
if ( (scalar(@cle_autre_nuc)) >0){
	foreach (@cle_autre_nuc){
		print("I.3 il y a aussi dans nos séquences $autre_nuc{$_} \"$_\".\n"); 
	}
}
#si aucun nuc autre que ATCG alors on l'indique
else{
print ("I.3 il n'y a que des A,T,C,G dans nos séquences\n");
}

