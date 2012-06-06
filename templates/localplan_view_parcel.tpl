<div class="localplan" style="display:block;">
	<div class="divcell">
		<div class="divtitle">{$data.parcel.regionId} of "{$data.world}"</div>
		<img class="parcelimg" src="{$data.morg_wi_url_root}/localPlan/{$data.parcel.world}__{$data.parcel.regionId}.png">
		<div class="divtxt">
			<ul>
				<li>surface : {$data.parcel.surface} block&#178;</li>
				<li>{if $data.parcel.owner}owner : {$data.parcel.owner}, {/if}{$data.parcel.buyStatus|lower|capitalize}</li>
				<li>price : {$data.parcel.price}</li>
				<li>
					<a href="#" class=" dynmapcoord" rel="{ldelim}'container':'#{$data.uid}','world':'{$data.world}','map':'surface','zoom':2,'x':{$data.parcel.baryX},'y':64,z:{$data.parcel.baryZ}{rdelim}">
						onMap
					</a>
				</li>		
			</ul>
		</div>	
	</div>
</div>	