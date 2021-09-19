class Instant_projectile{
  int damage, pierce;
  
  String damage_type, bullet_type;
  Tower fired_from_tower;

  Instant_projectile(Tower fired_from_tower, Mob target, String bullet_type){
    this.fired_from_tower=fired_from_tower;
    this.bullet_type = bullet_type;
    set_stats();
    hit(target);
  }
  
  void verif_damage_type(){
    if(damage_type.equals(get_damage_type(bullet_type)))  return;
    println("NOT GOOD ! Projectile :", bullet_type, "gives", damage_type, "and", get_damage_type(bullet_type));
  }
  
  void hit(Mob target){
    int nb_layers_popped=target.pop_layers(damage, true, damage_type);
    fired_from_tower.pop_count+=nb_layers_popped;
    joueur.game_pop_count+=nb_layers_popped;
    if(target.layers<=0){
      enemis.remove(target);
    }
  }
  
  void set_stats(){
    switch(bullet_type){
      case "bullet":
        damage = 2; pierce = 1;
        damage_type = "sharp";
        break;
      case "full metal bullet":
        damage = 4; pierce = 1;
        damage_type = "normal";
        break;
      case "point five bullet":
        damage = 7; pierce = 1;
        damage_type = "normal";
        break;
      case "deadly bullet":
        damage = 18; pierce = 1;
        damage_type = "normal";
        break;
      default:
        println("ERROR : Shoot type ", bullet_type, " not suitable for shooting bullet");
        break;
    }
  }
  
}
