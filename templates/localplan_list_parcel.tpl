<h2>Parcels list of "{$data.world}"</h2>
<div class="localplan" style="display:block;">
{foreach from=$data.parcels item=parcel}
<div class="divcell" style="{cycle values="clear:both;,,"}">
	<div class="divtitle"><a href="#" class=" dynmapcoord" rel="{ldelim}'container':'#{$data.uid}','world':'{$data.world}','map':'surface','zoom':6,'x':{$parcel.baryX},'y':64,z:{$parcel.baryZ}{rdelim}">{$parcel.regionId}</a></div>
	<img class="parcelimg" style="width:100px" src="{$data.morg_wi_url_root}/localPlan/{$parcel.world}__{$parcel.regionId}.png">
	<div class="divtxt">
		<ul>
			<li>surface : {$parcel.surface} block&#178;</li>
			<li>{if $parcel.owner}owner : {$parcel.owner}, {/if}{$parcel.buyStatus|lower|capitalize}</li>
			<li>price : {$parcel.price}</li>
			<li>
				<a href="./{$parcel.regionId}">
					detail
				</a>
			</li>		
		</ul>
	</div>	
</div>
{/foreach}
</div>	
