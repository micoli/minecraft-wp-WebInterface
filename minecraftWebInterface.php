<?php
/*
Plugin Name: Wordpress Minecraft Integration
Plugin URI: http://craft.micoli.org
Description: Basic interface between wordpress and bukkit server
Author: o.michaud
Version: 0.2
Author URI: http://craft.micoli.org
*/
include_once dirname(__FILE__)."/../morg_wp_plugin/morg_wp_plugin.php";



class morg_web_interface extends morg_wp_plugin{
	var $prefix = "morg";
	var $pluginName="";

	var $adminMenu = array(
		"MinecraftWebInterface"=>array(
			"page_title"=>"Minecraft WebInterface",
			"menu_title"=>"Minecraft WebInterface",
			"capability"=>'manage_options',
			"function"	=>"admin__main"
		)
	);
	
	function __construct(){
		parent::__construct();
		$this->jsonapi = new JSONAPI(
			get_option('morg_ah_jsonapi_host'		),
			get_option('morg_ah_jsonapi_port'		),
			get_option('morg_ah_jsonapi_user'		),
			get_option('morg_ah_jsonapi_password'	),
			get_option('morg_ah_jsonapi_salt'		)
		);
	}

	function wp_enqueue_script__localplancss() {
		wp_enqueue_style ( 'localplancss'		, get_site_url().'/wp-content/plugins/minecraft-wp-WebInterface/localplan.css');
	}
	
	function admin__main() {
		if($_POST['morg_wi_hidden'] == 'Y') {
			update_option('morg_wi_export_folder', $_POST['morg_wi_export_folder']);
			update_option('morg_wi_url_root', $_POST['morg_wi_url_root']);
			update_option('morg_wi_export_root', $_POST['morg_wi_export_root']);
			update_option('morg_wi_heroes_page', $_POST['morg_wi_heroes_page']);
			update_option('morg_wi_localplan_page', $_POST['morg_wi_localplan_page']);
			update_option('morg_ah_jsonapi_host'	, $_POST['morg_ah_jsonapi_host']);
			update_option('morg_ah_jsonapi_user'	, $_POST['morg_ah_jsonapi_user']);
			update_option('morg_ah_jsonapi_password', $_POST['morg_ah_jsonapi_password']);
			update_option('morg_ah_jsonapi_port'	, $_POST['morg_ah_jsonapi_port']);
			update_option('morg_ah_jsonapi_salt'	, $_POST['morg_ah_jsonapi_salt']);
			
			print sprintf('<div class="updated"><p><strong>%s</strong></p></div>', __('Options saved.' ));
		}
		$morg_wi_export_folder		= get_option('morg_wi_export_folder',realpath(dirname(__FILE__))."/export/items/");
		$defaultUrl					= realpath(dirname(__FILE__))."/export/";
		$morg_wi_url_root			= get_option('morg_wi_url_root',get_option('siteurl','').'/'.substr($defaultUrl,strpos($defaultUrl,"wp-content")));
		$defaultUrl					= realpath(dirname(__FILE__))."/";
		$morg_wi_export_root		= get_option('morg_wi_export_root',get_option('siteurl','').'/'.substr($defaultUrl,strpos($defaultUrl,"wp-content")).'image');
		$morg_wi_heroes_page		= get_option('morg_wi_heroes_page','heroes');
		$morg_wi_localplan_page		= get_option('morg_wi_localplan_page','localplan');
		$morg_ah_jsonapi_host		= get_option('morg_ah_jsonapi_host'		,"127.0.0.1");
		$morg_ah_jsonapi_port		= get_option('morg_ah_jsonapi_port'		,"20059");
		$morg_ah_jsonapi_user		= get_option('morg_ah_jsonapi_user'		,"user");
		$morg_ah_jsonapi_password	= get_option('morg_ah_jsonapi_password'	,"password");
		$morg_ah_jsonapi_salt		= get_option('morg_ah_jsonapi_salt'		,"salt goes here");
		
		$form = "
				<div class=\"wrap\">
				<h2>" . __( 'MineCraft Wordpress Interface', 'morg_wi_trdom' ) . "</h2>
				<form name=\"morg_wi_form\" method=\"post\" action=\"".str_replace( '%7E', '~', $_SERVER['REQUEST_URI']) ."\">
				<input type=\"hidden\" name=\"morg_wi_hidden\" value=\"Y\">
				<h4>" . __( 'Settings', 'morg_wi_trdom' ) . "</h4>
				<p>". __("Export Folder: "		)."<input type=\"text\" name=\"morg_wi_export_folder\" 	value=\""	.$morg_wi_export_folder		."\" size=\"90\">". __(" ex: /var/www/....") ."</p>
				<hr />
				<p>". __("Url Root: "			)."<input type=\"text\" name=\"morg_wi_url_root\" 		value=\""	.$morg_wi_url_root			."\" size=\"90\">". __(" ex: /wp-content/....") ."</p>
				<p>". __("export Http Root: "	)."<input type=\"text\" name=\"morg_wi_export_root\" 	value=\""	.$morg_wi_export_root		."\" size=\"90\">". __(" ex: /wp-content/..../images") ."</p>
				<hr />
				<p>". __("Heroes page: "		)."<input type=\"text\" name=\"morg_wi_heroes_page\" 	value=\""	.$morg_wi_heroes_page		."\" size=\"90\">". __(" ex: heroes") ."</p>
				<p>". __("LocalPlan page: "		)."<input type=\"text\" name=\"morg_wi_localplan_page\" value=\""	.$morg_wi_localplan_page	."\" size=\"90\">". __(" ex: localplan") ."</p>
				<hr />
				<p>". __("JsonApi server: "		)."<input type=\"text\" name=\"morg_ah_jsonapi_host\"		value=\""	.$morg_ah_jsonapi_host		."\" size=\"90\">". __(" ex: /var/www/....") ."</p>
				<p>". __("JsonApi port: "		)."<input type=\"text\" name=\"morg_ah_jsonapi_port\"		value=\""	.$morg_ah_jsonapi_port		."\" size=\"90\">". __(" ex: /var/www/....") ."</p>
				<p>". __("JsonApi user: "		)."<input type=\"text\" name=\"morg_ah_jsonapi_user\"		value=\""	.$morg_ah_jsonapi_user		."\" size=\"90\">". __(" ex: /var/www/....") ."</p>
				<p>". __("JsonApi password: "	)."<input type=\"text\" name=\"morg_ah_jsonapi_password\"	value=\""	.$morg_ah_jsonapi_password	."\" size=\"90\">". __(" ex: /var/www/....") ."</p>
				<p>". __("JsonApi salt: "		)."<input type=\"text\" name=\"morg_ah_jsonapi_salt\"		value=\""	.$morg_ah_jsonapi_salt		."\" size=\"90\">". __(" ex: /var/www/....") ."</p>
				<hr />
				<p class=\"submit\">
					<input type=\"submit\" name=\"Submit\" value=\"". __('Update Options', 'morg_wi_trdom' ) ."\" />
				</p>
				</form>
			</div>";
		print $form;
	}

	function getIngredient($id,$arrItems){
		return get_option('morg_wi_url_root').'items/'.(is_int($id)?$arrItems[$id]:$id).'_000.png';
	}

	
	function displayRecipe($name,$arrItems){
		if($name!='LEVER' && $name!='FENCE'&& $name!='CHEST'){
		//	return '';
		}

		$templateRecipe='';
		for($i=0;$i<3;$i++){
			for($j=0;$j<3;$j++){
				//$data[''][$j][$i]=;
				//$templateRecipe = str_replace("__CELL_".$j.$i."__",str_replace('_XY_','_'.$j.$i.'_',$cell),$templateRecipe);
			}
		}
		$item = json_decode(file_get_contents(realpath(get_option('morg_wi_export_folder')."/items/".$name.'.json')));
		if(isset($item->listRecipes) && is_array($item->listRecipes) && count($item->listRecipes)>0 ){
			$result='';

			foreach ($item->listRecipes as $kl=>$recipe){
				$data[$kl] = array(
					'col'=>array(),
					'str'=>array()
				);
				for($i=0;$i<3;$i++){
					for($j=0;$j<3;$j++){
						$data[$kl]['col'][$j][$i]="";
						$data[$kl]['str'][$j][$i]="";
					}
				}
				$returnRecipe=$templateRecipe;
				$rows = $item->listRecipes[0]->rows;
				$ingredients = $item->listRecipes[0]->ingredients;
				$res = array();
				foreach($rows as $k=>$row){
					$k = $k;//+2-$recipe->recipe->width;
					$res[$k]=array();
					for($i=0;$i<strlen($row);$i++){
						$col = $row[$i];
						$data[$kl]['col'][($k+3-$recipe->recipe->width)][$i]=$this->getIngredient($ingredients->$col->type,$arrItems);
						$data[$kl]['str'][($k+3-$recipe->recipe->width)][$i]=$arrItems[$ingredients->$col->type];
						$res[$k][$i] = $this->getIngredient($ingredients->$col->type,$arrItems);
					}
				}
				$data[$kl]['col_result'] = $this->getIngredient($item->listRecipes[0]->output->type,$arrItems);
				$data[$kl]['str_result'] = $arrItems[$item->listRecipes[0]->output->type];
			}
			return $data;
		}else{
			return array();
		}
		return array();
	}

	function shortcode__recipes($atts, $content = null) {
		extract(shortcode_atts(array(
			'item' => '___ALL___'
		), $atts));
		$result = "";
		
		$allItems = json_decode(file_get_contents(get_option('morg_wi_export_folder').'/items/__allitems.json'));
		$arrItems = array();
		foreach($allItems as $k=>$vitem){
			if (!array_key_exists($vitem->id,$arrItems)){
				$arrItems[$vitem->id]=$vitem->name;
			}
		}
		$data=array();
		if ($item == '___ALL___'){
			foreach($allItems as $k=>$vitem){
				$data['items'][$vitem->name]=$this->displayRecipe($vitem->name,$arrItems);
			}
		}else{
			$data['items'][$item]=$this->displayRecipe($item,$arrItems);
		}
		$data['morg_wi_export_root'		]= get_option('morg_wi_export_root');
		$data['morg_wi_export_folder'	]= get_option('morg_wi_export_folder');
		$smarty = self::getSmarty(__FILE__);
		$smarty->assign('datas',$data);
		//$result .= "<pre>".print_r($data,true)."</pre>";
		$result .= $smarty->fetch('templates/recipe_list.tpl');
		
		print  $result;
	}

	function shortcode__classes($atts, $content = null) {
		extract(shortcode_atts(array(
			'classe'	=> '___ALL___',
			'skill'		=> 1,
			'armor'		=> 1,
			'weapon'	=> 1,
			'graph'		=> 1
		), $atts));
		$result = "";

		$allPrm = json_decode(file_get_contents(get_option('morg_wi_export_folder').'/heroes/__allclasses.json'));
		if(is_object($allPrm)){
			$allPrm = morg_wp_tools::object2array($allPrm);
			if ($classe != '___ALL___'){
				$allPrm['classes']=array($classe=>$allPrm['classes'][$classe]);
			}else{
				ksort($allPrm['classes']);
			}
			foreach($allPrm['classes'] as &$class){
				sort($class['allowedWeapons']);
				sort($class['allowedArmor']);
				sort($class['skills']);
			}
			$arrItems = array();
			$smarty = self::getSmarty(__FILE__);
			$allPrm['morg_wi_items_folder'	] = get_option('morg_wi_items_folder');
			$allPrm['morg_wi_heroes_folder'	] = get_option('morg_wi_heroes_folder');
			$allPrm['morg_wi_url_root'		] = get_option('morg_wi_url_root');
			$allPrm['morg_wi_export_root'	] = get_option('morg_wi_export_root');
		}
		if ($classe == '___ALL___'){
			$allPrm['menu']=true;
		}
		$allPrm['uid'		]=date('YmdHisu');
		$allPrm['withSkill'	]=$skill;
		$allPrm['withArmor'	]=$armor;
		$allPrm['withWeapon']=$weapon;
		$allPrm['withGraph']=$graph;
		//db($allPrm);
		$smarty->assign('data',$allPrm);
		print $smarty->fetch('templates/classes.tpl');
	}

	function shortcode__config($atts, $content = null) {
		extract(shortcode_atts(array(
		), $atts));
		$result = "";

		$allClasses = json_decode(file_get_contents(get_option('morg_wi_export_folder').'/heroes/__allclasses.json'));
		if(is_object($allClasses)){
			$allPrm = morg_wp_tools::object2array($allClasses);
			$smarty = self::getSmarty(__FILE__);
			$smarty->assign('data',$allPrm);
			print $smarty->fetch('templates/config.tpl');
			//db($allPrm);
		}
	}

	function wp_add_action__wp_enqueue_scripts__jquery(){
		wp_deregister_script( 'jquery' );
		wp_register_script	( 'jquery' , 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js');
		wp_enqueue_script	( 'jquery' );
	}
	
	function wp_add_action__init__heroes_page(){
		global $wp,$wp_rewrite;
		$wp->add_query_var('hero_mode');
		$wp->add_query_var('hero_player');
		$wp_rewrite->add_rule(
			get_option('morg_wi_heroes_page').'/player/([^/]+)', 
			'index.php?pagename='.get_option('morg_wi_heroes_page').'&hero_mode=player&hero_player=$matches[1]', 
			'top'
		);
		//$wp_rewrite->flush_rules(false);
	}
	
	function shortcode__heroes($atts, $content = null) {
		global $wp;
		
		extract(shortcode_atts(array(
		), $atts));
		
		$allClasses = json_decode(file_get_contents(get_option('morg_wi_export_folder').'/heroes/__allheroes.json'));
		if(is_object($allClasses)){
			$allHeroes = morg_wp_tools::object2array($allClasses);
		}else{
			print "no heroes json file";
			return;
		}	
		if(array_key_exists('hero_mode',$wp->query_vars)){
			$hero_mode = $wp->query_vars['hero_mode'];
		}else{
			$hero_mode = 'list';
		}
		include('skin2/backend/backend.php');
		$exportPath='/var/www/wp/wp-content/export/images';
		$smarty = self::getSmarty(__FILE__);
		$data = array('morg_wi_url_root'=>get_option('morg_wi_url_root'));
		switch ($hero_mode){
			case 'list':
				foreach($allHeroes as $name=>$hero){
					minecraft_skin_download($exportPath,$name);
				}
				$data['heroes']	=$allHeroes;
				$template='templates/heroes_list.tpl';
			break;
			case 'player':
				if(array_key_exists('hero_player',$wp->query_vars) && array_key_exists($wp->query_vars['hero_player'], $allHeroes)){
					$name = $wp->query_vars['hero_player'];
				}else{
					if(count($allHeroes)>0){
						$name = array_pop(array_keys($allHeroes));
					}else{
						print "heroes json empty";
						return;
					}
				}
				$data['hero'] = $allHeroes[$name];
				$data['hero']['name']=$name;
				$data['hero']['imgName']=$name;
				if(!file_exists($exportPath.'/skins/'.$name.'/base.png')){
					$data['hero']['imgName']="Notch";
				}
				if(isset($refresh)) minecraft_skin_delete($exportPath,$name);
				minecraft_skin_download($exportPath,$name);
				$template='templates/heroes_player.tpl';
			break;
		}
		$smarty->assign('data',$data);
		print $smarty->fetch($template);
	}
	
	function wp_add_action__init__localplan_page(){
		global $wp,$wp_rewrite;
		$wp->add_query_var('lp_mode');
		$wp->add_query_var('lp_world');
		$wp->add_query_var('lp_parcel');
		$wp_rewrite->add_rule(
			get_option('morg_wi_localplan_page').'/([^/]+)/([^/]+)', 
			'index.php?pagename='.get_option('morg_wi_localplan_page').'&lp_mode=view_parcel&lp_world=$matches[1]&lp_parcel=$matches[2]', 
			'top'
		);
		$wp_rewrite->add_rule(
			get_option('morg_wi_localplan_page').'/([^/]+)', 
			'index.php?pagename='.get_option('morg_wi_localplan_page').'&lp_mode=view_world&lp_world=$matches[1]', 
			'top'
		);
		$wp_rewrite->flush_rules(false);
	}
	
	function shortcode__localplan($atts, $content = null) {
		global $wp;
	
		extract(shortcode_atts(array(
			'uid'=>'mcmap'
		), $atts));
		if(array_key_exists('lp_mode',$wp->query_vars)){
			$lp_mode = $wp->query_vars['lp_mode'];
		}else{
			$lp_mode = 'list_world';
		}
		$result = $this->jsonapi->call("webInterface.localplanParcels",array());

		//$allParcels = json_decode(file_get_contents(get_option('morg_wi_export_folder').'localPlan/__allparcels.json'));
		$allParcels = $result['success'];
		if(is_object($allParcels) or is_array($allParcels)){
			$allParcels = morg_wp_tools::object2array($allParcels);
		}else{
			print "no parcels json file";
			return;
		}
		$smarty = self::getSmarty(__FILE__);
		$data = array(
			'morg_wi_url_root'		=> get_option('morg_wi_url_root'),
			'morg_wi_localplan_page'=> get_option('morg_wi_localplan_page'),
			'uid'					=> $uid
		);
		switch ($lp_mode){
			case 'list_world';
				$allWorld = array();
				foreach($allParcels as $parcel){
					$allWorld[$parcel['world']]++;
				}
				$data['worlds'	]=$allWorld;
				$data['uid'		]=$uid;
				$template='templates/localplan_list_world.tpl';
			break;
			case 'view_world';
				$parcels = array();
				foreach($allParcels as $parcel){
					if($parcel['world']== $wp->query_vars['lp_world']){
						$parcels[]=$parcel;
					}
				}
				$data['parcels']=$parcels;
				$data['world']=$wp->query_vars['lp_world'];
				$template='templates/localplan_list_parcel.tpl';
			break;
			case 'view_parcel';
				$parcel = array();
				foreach($allParcels as $parcel){
					if($parcel['world']== $wp->query_vars['lp_world'] && $parcel['regionId']== $wp->query_vars['lp_parcel']){
						$parcel=$parcel;
					}
				}
				$data['parcel']=$parcel;
				$data['world']=$wp->query_vars['lp_world'];
				$template='templates/localplan_view_parcel.tpl';
			break;
		}
		$smarty->assign('data',$data);
		print $smarty->fetch($template);
	}
}
$morg_web_interface = new morg_web_interface();
?>
