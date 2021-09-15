class dart_monkey extends Tower{
  
  dart_monkey(String type, float x, float y){
    super(type, x, y);
  }
  
  void set_param_tower(){
    couleur=color(0, 0, 255);
    price=200;
    size=base_size;
    range=128;
    projectile_speed=20;
    
    shoots_list.append("dart");
    deviation_list.append(0);
    attack_speed_list.append(1.03);        

    projectile_damage_list.append(1);
    projectile_pierce_list.append(1);
    projectile_hit_exceptions.add(new StringList());
  }
}

class wizard_monkey extends Tower{

  wizard_monkey(String type, float x, float y){
    super(type, x, y);
  }
  
  void set_param_tower(){
    couleur=color(209, 34, 234);
    price=550;
    size=base_size*1.5;
    range=152;
    projectile_speed=10;
    shoots_list.append("purple ball");
    deviation_list.append(0);
    attack_speed_list.append(0.91);

    projectile_damage_list.append(1);
    projectile_pierce_list.append(2);
    projectile_hit_exceptions.add(new StringList());
  }
}

class sniper extends Tower{

  sniper(String type, float x, float y){
    super(type, x, y);
  }
  
  void set_param_tower(){
    priority="strong";
    couleur=color(0, 128, 64);
    price=350;
    size=base_size;
    range=24;                //c'est un sniper donc ca c'est juste pour la prévisu quand on sélectionne la tour
    
    shoots_list.append("instant");
    deviation_list.append(0);
    attack_speed_list.append(0.45);
    
    projectile_damage_list.append(2);
    projectile_pierce_list.append(1);
    projectile_hit_exceptions.add(new StringList());
  }
  
  ArrayList<Mob> get_enemis_in_range(){
    ArrayList<Mob> liste= new ArrayList<Mob>();
    for(Mob mob : enemis){
      if(can_detect(mob, detects_camo))  liste.add(mob);       //on ne l'ajoute que si il n'est pas caché, il n'est pas camo ou alors on les détecte
    }
    return liste;
  }
  
}

class tack_shooter extends Tower{

  tack_shooter(String type, float x, float y){
    super(type, x, y);
  }
  
  void set_param_tower(){
    couleur=color(255, 128, 192);
    price=360;
    size=base_size*1.3;
    range=90;
    projectile_speed=10;
    
    for(int i=0; i<8; i++){
      shoots_list.append("tack");
      deviation_list.append(i*PI/4);
      attack_speed_list.append(0.6);
      projectile_damage_list.append(1);
      projectile_pierce_list.append(1);
      projectile_hit_exceptions.add(new StringList());
    }
  }
}

class dartling_gun extends Tower{

  dartling_gun(String type, float x, float y){
    super(type, x, y);
  }
  
  void set_param_tower(){
    couleur = color(180, 230, 30);
    price = 950;
    size = base_size;
    projectile_speed=20;
    detects_camo=true;
    max_dispersion = 0.4;   //en radians
    range=44;    //seuleument pour le visuel
    
    shoots_list.append("dart");
    deviation_list.append(0);
    attack_speed_list.append(5);
    projectile_damage_list.append(1);
    projectile_pierce_list.append(1);
    projectile_hit_exceptions.add(new StringList());
  }
  
  void shoot(){
    
    if(round.waiting_next_round)  return;      //sinon lance un projectile parasite
    
    FloatList directions_list=new FloatList();
    for(int i=0; i<shoots_list.size(); i++){
      String shoot_type = shoots_list.get(i);
      float deviation = deviation_list.get(i);
      float time_before_next_attack = time_before_next_attack_list.get(i);
      float attack_speed = attack_speed_list.get(i);
      int projectile_damage = projectile_damage_list.get(i);
      int projectile_pierce = projectile_pierce_list.get(i);
      StringList hit_exceptions = projectile_hit_exceptions.get(i);
      
      int compteur_dir=0;
      while(time_before_next_attack<=0){
        float direction=atan2(mouseY-y, mouseX-x);
        if(i==0){
          direction += random(-max_dispersion/2, max_dispersion/2);
          directions_list.append(direction);
        }
        else{
          direction=directions_list.get(compteur_dir);
        }
        projectiles.add(new Projectile(this, x, y, projectile_speed, direction+deviation, projectile_damage, projectile_pierce, projectile_can_bounce, shoot_type, hit_exceptions));
        time_before_next_attack += 1 / attack_speed;      //affecter la valeur reste utile pour le while (sinon il faut remplacer par un _list.get(i)<=0 )
        time_before_next_attack_list.set(i, time_before_next_attack);
        
        compteur_dir++;
      }
    }
  }
  
}

class boomerang_thrower extends Tower{

  boomerang_thrower(String type, float x, float y){
    super(type, x, y);
  }
  
  void set_param_tower(){
    couleur = color(255, 242, 0);
    price = 400;
    size = base_size;
    projectile_speed=15;
    range = 165;
    
    shoots_list.append("boomerang");
    deviation_list.append(0);
    attack_speed_list.append(0.75);
    projectile_damage_list.append(1);
    projectile_pierce_list.append(3);
    projectile_hit_exceptions.add(new StringList());
  }
  
}

class ninja_monkey extends Tower{

  ninja_monkey(String type, float x, float y){
    super(type, x, y);
  }
  
  void set_param_tower(){
    couleur = color(255, 0, 0);
    price = 500;
    size = base_size;
    projectile_speed=20;
    range = 152;
    detects_camo=true;
    
    shoots_list.append("shuriken");
    deviation_list.append(0);
    attack_speed_list.append(1.67);
    projectile_damage_list.append(1);
    projectile_pierce_list.append(2);
    projectile_hit_exceptions.add(new StringList());
  }
}


class spike_factory extends Tower{

  spike_factory(String type, float x, float y){
    super(type, x, y);
  }
  
  void set_param_tower(){
    couleur = color(0, 0, 0);
    price = 700;
    size = base_size;
    projectile_speed=10;
    range = 134;
    detects_camo=true;
    
    shoots_list.append("spike");
    deviation_list.append(0);
    attack_speed_list.append(0.43);
    projectile_damage_list.append(1);
    projectile_pierce_list.append(5);
    projectile_hit_exceptions.add(new StringList());
  }
  
  void shoot(){
    if(round.waiting_next_round)  return;      //sinon lance un spike parasite
    for(int i=0; i<shoots_list.size(); i++){
      String shoot_type = shoots_list.get(i);
      float time_before_next_attack = time_before_next_attack_list.get(i);
      float attack_speed = attack_speed_list.get(i);
      int projectile_damage = projectile_damage_list.get(i);
      int projectile_pierce = projectile_pierce_list.get(i);
      StringList hit_exceptions = projectile_hit_exceptions.get(i);
      
      while(time_before_next_attack <= 0){
        if(on_track_pos.size()==0)  return;
        int index = int(random(on_track_pos.size()));
        spikes.add(new Spikes(this, on_track_pos.get(index)[0], on_track_pos.get(index)[1], projectile_damage, projectile_pierce, shoot_type, hit_exceptions, projectile_speed));
        
        time_before_next_attack += 1 / attack_speed;      //affecter la valeur reste utile pour le while (sinon il faut remplacer par un _list.get(i)<=0 )
        time_before_next_attack_list.set(i, time_before_next_attack);
      }
    }  
  }
}



class Tower{
  boolean highlight=false;
  float x, y;
  float range;
  String priority="first";
  float projectile_speed;
  float base_size=60;
  float size;
  float pop_count=0;
  String type;
 
  boolean projectile_can_bounce;
  float projectile_max_bounce_distance;
  float max_dispersion;
  
  boolean detects_camo=false;
  
  color couleur;
  int price=0;
  
  int path_1_progression;
  int path_2_progression;
  
  StringList shoots_list;
  FloatList  deviation_list;
  FloatList attack_speed_list;
  FloatList time_before_next_attack_list;
  IntList projectile_damage_list;
  IntList projectile_pierce_list;
  ArrayList<StringList> projectile_hit_exceptions;
  ArrayList<float[]> on_track_pos;      //sert uniquement aux spikes factory
  
  ArrayList<Tower> towers_affected_by_ability = new ArrayList<Tower>();
  float ability_use_time, ability_cooldown_timer;
  Ability linked_ability;
  
  
  Tower(String type, float x, float y){
    this.x=x;
    this.y=y;
    this.type=type;
    init_param_tower();
    set_param_tower();
    init_time_before_next_attack_list();
  }
  
  //subclasses func
  void set_param_tower(){}
  
  void show(){
    fill(couleur);
    noStroke();
    ellipse(x, y, size, size);
    if(highlight)  show_range(true);
  }
  
  void show_range(boolean can_place_tower){
    strokeWeight(1);
    if(can_place_tower){
      fill(0, 0, 0, 50);
      stroke(0, 0, 0);
      
    }
    else{
      fill(255, 0, 0, 50);
      stroke(255, 0, 0);
    }
    ellipse(x, y, range*2, range*2);
  }
  
  void init_time_before_next_attack_list(){
    time_before_next_attack_list = new FloatList();
    for(int i=0; i<shoots_list.size(); i++){
      time_before_next_attack_list.append(0);      
    }
  }
  
  
  void init_param_tower(){
    shoots_list=new StringList();
    deviation_list=new FloatList();
    attack_speed_list = new FloatList();
    time_before_next_attack_list = new FloatList();
    projectile_damage_list = new IntList();
    projectile_pierce_list = new IntList();
    projectile_hit_exceptions = new ArrayList<StringList>();
  }
  
  
  ArrayList<Mob> get_enemis_in_range(){
    ArrayList<Mob> liste= new ArrayList<Mob>();
    for(Mob mob : enemis){
      if(distance(new float[] {mob.x, mob.y}, new float[] {x, y})<=range+mob.size/2){    //je prefere reconstruire 1 a 1 : évite peut etre des prbms de copie
        if(can_detect(mob, detects_camo))  liste.add(mob);       //on ne l'ajoute que si il n'est pas caché, il n'est pas camo ou alors on les détecte
      }
    }
    return liste;
  }
    
 
  Mob get_target(ArrayList<Mob> detected_mobs){
    //donne la cible selon la priorité, necessite de détecter au moins un mob
    Mob target= detected_mobs.get(0);
    if(priority.equals("first")){
      float avancement_max=0;
      for(Mob mob : detected_mobs){
        if(mob.avancement>avancement_max){
          target=mob;
          avancement_max=mob.avancement;
        }
      }
    }
    else if(priority.equals("strong")){
      int max_priority=0;
      float avancement_max=0;
      for(Mob mob : detected_mobs){
        if(force_list.get(mob.type)>max_priority || force_list.get(mob.type)==max_priority && mob.avancement>avancement_max){
          target=mob;
          max_priority=force_list.get(mob.type);
          avancement_max=mob.avancement;
        }
      }
    }
    else if(priority.equals("last")){
      float avancement_min=map.longueur_map+1;
      for(Mob mob : detected_mobs){
        if(mob.avancement<avancement_min){
          target=mob;
          avancement_min=mob.avancement;
        }
      }
    }
    else if(priority.equals("close")){ 
      float dist_min=Float.POSITIVE_INFINITY;
      for(Mob mob : detected_mobs){
        if(distance(new float[] {x, y}, new float[] {mob.x, mob.y})<dist_min){
          target=mob;
          dist_min=distance(new float[] {x, y}, new float[] {mob.x, mob.y});
        }
      }
    }
    return target;
  }
  
  
  void update(){
    update_time_before_next_attack();      //a faire chaque frame
    shoot();
  }
  
  void shoot(){
      
    if(enemis.size() == 0)  return;
    
    ArrayList<Mob> detected_mobs = get_enemis_in_range();
    if(detected_mobs.size() == 0 )  return;                        //si on ne detecte aucun mob, pas la peine de continuer
    
    Mob target=get_target(detected_mobs);                          //on garde le meme mob
    
    
    for(int i=0; i<shoots_list.size(); i++){
      String shoot_type = shoots_list.get(i);
      float deviation = deviation_list.get(i);
      float time_before_next_attack = time_before_next_attack_list.get(i);
      float attack_speed = attack_speed_list.get(i);
      int projectile_damage = projectile_damage_list.get(i);
      int projectile_pierce = projectile_pierce_list.get(i);
      StringList hit_exceptions = projectile_hit_exceptions.get(i);
      
      while(time_before_next_attack <= 0){

        if(shoot_type.equals("laser")){
          lasers.add(new Laser(this, x, y, projectile_damage, projectile_pierce, target, hit_exceptions));
        }
        else if(shoot_type.equals("boomerang")){
          shoot_boomerang(target, projectile_damage, projectile_pierce, hit_exceptions);
        }
        else if(shoot_type.equals("instant")){
          int nb_layers_popped=target.pop_layers(projectile_damage, true, "dart", hit_exceptions);
          pop_count+=nb_layers_popped;
          joueur.game_pop_count+=nb_layers_popped;
          if(target.layers<=0){
            enemis.remove(target);
            detected_mobs = get_enemis_in_range();
            if(detected_mobs.size() == 0 ){ //si on ne detecte aucun mob, pas la peine de continuer
              time_before_next_attack += 1 / attack_speed;      //affecter la valeur reste utile pour le while (sinon il faut remplacer par un _list.get(i)<=0 )
              time_before_next_attack_list.set(i, time_before_next_attack);
              return;
            }                    
            target=get_target(detected_mobs);
          }
        }
        else{
          if(type=="tack shooter"){
            Projectile temp=new Projectile(this, x, y, projectile_speed, deviation, projectile_damage, projectile_pierce, projectile_can_bounce, shoot_type, hit_exceptions);
            temp.has_max_range=true;
            temp.max_range=range;
            projectiles.add(temp);
          }
          else{
            float[] futur_pos = map.get_pos(target.avancement + target.speed);                              //on prévois juste un coup d'avance
            float direction=atan2(futur_pos[1]-y, futur_pos[0]-x);
            projectiles.add(new Projectile(this, x, y, projectile_speed, direction + deviation, projectile_damage, projectile_pierce, projectile_can_bounce, shoot_type, hit_exceptions));
            
            if(shoot_type.equals("flame")){                  //un wizard monkey de feu tire des projectiles a portée limitée
              projectiles.get(projectiles.size()-1).has_max_range=true;
              projectiles.get(projectiles.size()-1).max_range=range;
            }
          }
        }
        time_before_next_attack += 1 / attack_speed;      //affecter la valeur reste utile pour le while (sinon il faut remplacer par un _list.get(i)<=0 )
        time_before_next_attack_list.set(i, time_before_next_attack);
      }
    }
  }
  
  void update_time_before_next_attack(){
    if(round.waiting_next_round)  return;        //on ne compte pas le temps entre les rounds
    for(int i=0; i<time_before_next_attack_list.size(); i++){
      float timer = time_before_next_attack_list.get(i);
      if(timer>0)  time_before_next_attack_list.set(i, timer - joueur.game_speed / 60.);
    }
  }
  
  void shoot_boomerang(Mob target, int projectile_damage, int projectile_pierce, StringList hit_exceptions){
    float[] pos1 = new float[2];
    float[] pos2 = new float[2];
    float[] pos_finale=new float[2];
    float[] pos_inutile=new float[2];
    
    float[] futur_pos = map.get_pos(target.avancement + target.speed);                              //on prévois juste un coup d'avance
    if(distance(futur_pos, new float[] {x, y})>range)  futur_pos=new float[] {target.x, target.y};  //sauf si cela nous empeche de tapper la cible (plus de cercle sécants...)
    float[] temp = find_intersection_cercles(x, y, range/2, futur_pos[0], futur_pos[1], range/2);
    
    pos1[0] = temp[0];
    pos1[1] = temp[1];
    pos2[0] = temp[2];
    pos2[1] = temp[3];
    
    //on determine la pos du centre tel que le boomerang tappe le ballon avant d'etre a la moitié de son cercle
    
    //retourne l'équation de la droite sous la forme y=ax+b
    float a=(futur_pos[1]-y)/(futur_pos[0]-x); 
    float b=y-a*x;
    
    if(pos1[1] <= a * pos1[0] + b){
      pos_finale=pos1;
      pos_inutile=pos2;
    }
    else{
      pos_finale=pos2;
      pos_inutile=pos1;
    }
    
    if(target.x <= x){                //il faut inverser les pos
      pos_finale=pos_inutile;
    }
   
    boomerangs.add(new Boomerang(this, pos_finale[0], pos_finale[1], range/2, projectile_speed, projectile_damage, projectile_pierce, hit_exceptions));
    
  }
  
}
