{if $data.withGraph}
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
  google.load("visualization", "1", {ldelim}packages:["corechart"]{rdelim});
  google.setOnLoadCallback(drawChart);
  function drawChart() {ldelim}
	{foreach from=$data.classes item=classe}
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'level');
    data.addColumn('number', 'Mana');
    data.addColumn('number', 'Health');
    data.addRows([
      ['1', {$classe.baseMaxMana},{$classe.baseMaxHealth}],
      ['{math equation="x/4" x=$classe.maxLevel}',  {math equation="x+y*z/4" x=$classe.baseMaxMana y=$classe.maxLevel z=$classe.maxManaPerLevel},{math equation="x+y*z/4" x=$classe.baseMaxHealth y=$classe.maxLevel z=$classe.maxHealthPerLevel}],
      ['{math equation="x/2" x=$classe.maxLevel}',  {math equation="x+y*z/2" x=$classe.baseMaxMana y=$classe.maxLevel z=$classe.maxManaPerLevel},{math equation="x+y*z/2" x=$classe.baseMaxHealth y=$classe.maxLevel z=$classe.maxHealthPerLevel}],
      ['{math equation="x/4*3" x=$classe.maxLevel}',  {math equation="x+y*z/4*3" x=$classe.baseMaxMana y=$classe.maxLevel z=$classe.maxManaPerLevel},{math equation="x+y*z/4*3" x=$classe.baseMaxHealth y=$classe.maxLevel z=$classe.maxHealthPerLevel}],
      ['{math equation="x" x=$classe.maxLevel}', {math equation="x+y*z" x=$classe.baseMaxMana y=$classe.maxLevel z=$classe.maxManaPerLevel},{math equation="x+y*z" x=$classe.baseMaxHealth y=$classe.maxLevel z=$classe.maxHealthPerLevel}],
    ]);

    var options = {ldelim}
      width: 250, height: 150,
    {rdelim};

    var chart = new google.visualization.LineChart(document.getElementById('chart_div_{$data.uid}{$classe.name}'));
    chart.draw(data, options);
    {/foreach}
  {rdelim}
</script>
{/if}
{if $data.menu}
<ul>
{foreach from=$data.classes item=classe}
	<li><a href="#skill_{$classe.name}">{$classe.name}</a></li>
{/foreach}
</ul>
{/if}
{foreach from=$data.classes item=classe}
	<a name="skill_{$classe.name}"></a>
	<h1><u>{$classe.name}</u></h1>
	<div>
		<div style="float:left;width:300px">
			<i>{$classe.description}</i>
			<ul>
				<li>max level: {$classe.maxLevel}</li>
				<li>base health : {$classe.baseMaxHealth} ({$classe.maxHealthPerLevel}/level, {math equation="x+y*z" x=$classe.baseMaxHealth y=$classe.maxLevel z=$classe.maxHealthPerLevel}@L{$classe.maxLevel})</li>
				<li>base mana : {$classe.baseMaxMana} ({$classe.maxManaPerLevel}/level, {math equation="x+y*z" x=$classe.baseMaxMana y=$classe.maxLevel z=$classe.maxManaPerLevel}@L{$classe.maxLevel})</li>
			</ul>
		</div>
		{if $data.withGraph}<div style="float:right;" id="chart_div_{$data.uid}{$classe.name}" style="width: 250px; height: 150px;"></div>{/if}
	</div>
	{if $data.withArmor}
	<h2>Armors</h2>
	{foreach from=$classe.allowedArmor item=armor}
		<img src="{$data.morg_wi_export_root}/items/{$armor}_000.png" title="{$armor|lower|capitalize|replace:'_':' '}" alt="{$armor|lower|capitalize|replace:'_':' '}"/>
	{/foreach}
	{/if}
	{if $data.withWeapon}
	<h2>Weapons</h2>
	{foreach from=$classe.allowedWeapons item=weapon}
		<img src="{$data.morg_wi_export_root}/items/{$weapon}_000.png" title="{$weapon|lower|capitalize|replace:'_':' '}" alt="{$weapon|lower|capitalize|replace:'_':' '}"/>
	{/foreach}
	{/if}
	{if $data.withSkill}
		<br /><br />
		<table>
			<thead>
				<td><b>Skill</b></td>
				<td><b>Usage</b></td>
				<td><b>Notes</b></td>
				<td><b>Types</b></td>
			</thead>
		
		{foreach from=$classe.skills item=skill}
			<tr>
				<td>{$skill.name|capitalize}</td>
				<td>{$skill.usage}</td>
				<td>{$skill.notes|@join:","}</td>
				<td>{$skill.types|lower|@join:", "|lower|capitalize}</td>
			</tr>
		{/foreach}
		</table>
	{/if}
	<hr />
{/foreach}