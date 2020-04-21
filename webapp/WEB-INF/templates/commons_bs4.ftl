<#-- WARNING : be careful to white-space and lines break in FreeMarker macros.
 # This macro template can be used to output white-space-sensitive formats (like RSS files).
 # See http://dev.lutece.paris.fr/jira/browse/LUTECE-765
-->

<#include "util/calendar/macro_datepicker.ftl"  ignore_missing=true />
<#-- Do not remove this comment -->

<#-- Information about this commons file -->
<#macro commonsFile>commons_bs4.ftl</#macro>
<#macro commonsName>Commons Bootstrap 4.3</#macro>
<#macro commonsDescription>Freemarker Commons macros powered by Bootstrap CSS Framework 4.3</#macro>

<#macro coreAdminCSSLinks>
<link href="css/admin/style/bootstrap4/bootstrap.min.css" rel="stylesheet"> <!-- Bootstrap 4.3.1 -->
<link href="css/admin/style/bootstrap4/bootstrap-colorpicker.min.css" rel="stylesheet">
<link href="css/admin/style/bootstrap4/bootstrap-datepicker.min.css" rel="stylesheet">
<link href="css/admin/style/bootstrap4/all.min.css" rel="stylesheet"> <!-- Font-Awesome 5.8.1 -->
<link href="css/admin/style/bootstrap4/portal_admin.css" rel="stylesheet">
</#macro>

<#macro coreAdminJSLinks>
<script src="css/admin/style/bootstrap4/bootstrap.bundle.min.js"></script> <!-- Bootstrap 4.3.1 -->
<script src="css/admin/style/bootstrap4/bootstrap-colorpicker.min.js"></script> 
<script src="css/admin/style/bootstrap4/bootstrap-datepicker.min.js"></script> 
<!-- <script src="css/admin/style/bootstrap4/portal_admin.js"></script>  -->
</#macro>

<#global gClassActive='active' />


<#-- PAGINATION  -->
<#macro pagination paginator>
<#assign nbLinkPagesToDisplay = 10 />
<#assign offsetPrev = nbLinkPagesToDisplay / 2 />
<#assign offsetNext = nbLinkPagesToDisplay / 2 />
<#if ( paginator.pageCurrent <= nbLinkPagesToDisplay - offsetPrev )>
	<#assign offsetPrev = paginator.pageCurrent - 1 />
	<#assign offsetNext = nbLinkPagesToDisplay - offsetPrev />
<#elseif ( paginator.pageCurrent + offsetNext > paginator.pagesCount )>
	<#assign offsetNext = paginator.pagesCount - paginator.pageCurrent />
	<#assign offsetPrev = nbLinkPagesToDisplay - offsetNext />
</#if>

<#if ( paginator.pagesCount > 1 )>
	<#if ( paginator.pageCurrent - offsetPrev > 1 )>
		<@link href='${paginator.firstPageLink?xhtml}'>
			<@icon style='double-left' /> #i18n{portal.util.labelFirst}
		</@link>
	</#if>
	<#if ( paginator.pageCurrent > 1 )>
		<@link href='${paginator.previousPageLink?xhtml}'>
			<@icon style='angle-left' /> #i18n{portal.util.labelPrevious}
		</@link>
	<#else>
	</#if>
	<#if ( paginator.pageCurrent - offsetPrev > 1 )>
		<strong>...</strong>
	</#if>
	<#list paginator.pagesLinks as link>
		<#if link.index == paginator.pageCurrent>
			<strong>${link.name}</strong>
		<#else>
			<@link href='${link.url?xhtml}'>${link.name}</@link>
		</#if>
	</#list>
	<#if ( paginator.pageCurrent + offsetNext < paginator.pagesCount )>
		<strong>...</strong>
	</#if>
	<#if ( paginator.pageCurrent < paginator.pagesCount )>
		<@link href='${paginator.nextPageLink?xhtml}'>
			<@icon style='angle-right' />&nbsp;#i18n{portal.util.labelNext}
		</@link>
		<#if ( paginator.pageCurrent + offsetNext < paginator.pagesCount )>
			<@link href='${paginator.lastPageLink?xhtml}'>
				<@icon style='angle-double-right' />&nbsp;#i18n{portal.util.labelLast}
			</@link>
		</#if>
	<#else>
		&nbsp;&nbsp;
	</#if>
</#if>
</#macro>

<#-- PAGINATION ADMIN -->
<#macro paginationAdmin paginator combo=0 form=1 nb_items_per_page=nb_items_per_page showcount=1 showall=0>
<#if (paginator.pagesCount > 1) >
	<@paginationPageLinks paginator=paginator />
</#if>
<div class="float-right">
	<#if form == 1 >
		<@tform type='inline'>
			<@paginationItemCount paginator=paginator combo=combo nb_items_per_page=nb_items_per_page showcount=showcount showall=showall/>
		</@tform>
	<#else>
		<@paginationItemCount paginator=paginator combo=combo nb_items_per_page=nb_items_per_page showcount=showcount showall=showall/>
	</#if>
</div>
</#macro>

<#-- PAGINATION LINKS -->
<#macro paginationPageLinks paginator >
<#assign nbLinkPagesToDisplay = 10 />
<#assign offsetPrev = nbLinkPagesToDisplay / 2 />
<#assign offsetNext = nbLinkPagesToDisplay / 2 />
<#if ( paginator.pageCurrent <= nbLinkPagesToDisplay - offsetPrev )>
	<#assign offsetPrev = paginator.pageCurrent - 1 />
	<#assign offsetNext = nbLinkPagesToDisplay - offsetPrev />
<#elseif ( paginator.pageCurrent + offsetNext > paginator.pagesCount )>
	<#assign offsetNext = paginator.pagesCount - paginator.pageCurrent />
	<#assign offsetPrev = nbLinkPagesToDisplay - offsetNext />
</#if>
<@ul class='pagination pagination-sm'>
<#if ( paginator.pageCurrent - offsetPrev > 1 )>
	<li>
		<@link href='${paginator.firstPageLink?xhtml}'>
			${paginator.labelFirst}
		</@link>
	</li>
</#if>
<#if (paginator.pageCurrent > 1) >
	<li class="previous">
		<@link href='${paginator.previousPageLink?xhtml}'>
			${paginator.labelPrevious}
		</@link>
	</li>
<#else>
	<li class="disabled">
		<@link href='${paginator.firstPageLink?xhtml}'>${paginator.labelPrevious}</@link>
	</li>
</#if>
<#if ( paginator.pageCurrent - offsetPrev > 1 )>
	<li>
		<@link href='${(paginator.pagesLinks?first).url?xhtml}'><strong>...</strong></@link>
	</li>
</#if>
<#list paginator.pagesLinks as link>
	<#if ( link.index == paginator.pageCurrent )>
		<li class="active">
			<@link href='${link.url?xhtml}'>${link.name}</@link>
		</li>
	<#else>
		<li>
			<@link href='${link.url?xhtml}'>${link.name}</@link>
		</li>
	</#if>
</#list>
<#if ( paginator.pageCurrent + offsetNext < paginator.pagesCount )>
	<li>
		<@link href='${(paginator.pagesLinks?last).url?xhtml}'><strong>...</strong></@link>
	</li>
</#if>
<#if (paginator.pageCurrent < paginator.pagesCount) >
	<li class="next">
		<@link href="${paginator.nextPageLink?xhtml}">
			${paginator.labelNext}
		</@link>
	</li>
	<#if ( paginator.pageCurrent + offsetNext < paginator.pagesCount )>
		<li class="next">
			<@link href='${paginator.lastPageLink?xhtml}'>
				${paginator.labelLast}
			</@link>
		</li>
	</#if>
<#else>
	<li class="disabled">
		<@link href='${paginator.lastPageLink?xhtml}'>${paginator.labelNext}</@link>
	</li>
</#if>
</@ul>
</#macro>

<#-- PAGINATION COMBO -->
<#macro paginationCombo paginator nb_items_per_page=nb_items_per_page showall=0>
<@formGroup labelFor='${paginator.itemsPerPageParameterName}' labelKey='${paginator.labelItemCountPerPage}' formStyle='inline'>
<@inputGroup>
	<@select params='data-max-item="${paginator.itemsCount}"' size='sm' name='${paginator.itemsPerPageParameterName}' id='${paginator.itemsPerPageParameterName}' title='${paginator.labelItemCountPerPage}'>
  		<#list [ "10" , "20" , "50" , "100" ] as nb>
  			<#if nb_items_per_page = nb >
  				<option selected="selected" value="${nb}">${nb}</option>
  			<#else>
  				<option value="${nb}">${nb}</option>
  			</#if>
  		</#list>
  		<#if showall ==1>
  			<#if paginator.itemsCount &gt; 100 >
  				<option <#if nb_items_per_page?number = paginator.itemsCount?number >selected="selected"</#if> value="${paginator.itemsCount}" class="${nb_items_per_page}">#i18n{portal.util.labelAll}</option>
  			</#if>
  		</#if>
	</@select>
	<@inputGroupItem type='btn'>
		<@button type='submit' color='dark' size='sm' title='#i18n{portal.util.labelRefresh}' buttonIcon='check' hideTitle=['all'] />
	</@inputGroupItem>
</@inputGroup>
</@formGroup>
</#macro>

<#-- PAGINATION COUNT -->
<#macro paginationItemCount paginator combo=0 nb_items_per_page=nb_items_per_page showcount=1 showall=0>
<#-- Display combo -->
<#if combo == 1 >
  <@paginationCombo paginator=paginator nb_items_per_page=nb_items_per_page showall=showall />
</#if>
<#-- Display item count -->
<#if showcount == 1 >
<span class="showcount small">
	<#if (paginator.labelItemCount)?? && paginator.labelItemCount?has_content>&#160;${paginator.labelItemCount} : </#if> ${paginator.itemsCount}
</span>
</#if>
</#macro>

<#-- NAVIGATION -->
<#macro item_navigation item_navigator id="item-navigator">
<nav id="${id}" style="display:inline;">
<#if (item_navigator.currentItemId > 0)>
	<@aButton size='sm' href='${item_navigator.previousPageLink?xhtml}' title='#i18n{portal.util.labelPrevious}' buttonIcon='arrow-left' color='info' hideTitle=['xs','sm'] />
</#if>
<#if (item_navigator.currentItemId < item_navigator.listItemSize - 1) >
	<@aButton size='sm' href='${item_navigator.nextPageLink?xhtml}' title='#i18n{portal.util.labelNext}' buttonIcon='arrow-right' color='info' hideTitle=['xs','sm'] />
</#if>
</nav>
</#macro>

<#-- MESSAGES -->
<#macro messages errors=[] infos=[] warnings=[] errors_class="alert alert-danger" infos_class="alert alert-info" warnings_class="alert alert-warning">
<#if errors??>
	<#if errors?size &gt; 0 >
		<@alert color='danger' id='messages_errors_div'>
			<@button style='close' />
			<#list errors as error >
			<span class="icon"><@icon style='exclamation-circle' /></span> ${error.message}<br />
			</#list>
		</@alert>
	</#if>
</#if>
<#if infos??>
	<#if infos?size &gt; 0 >
		<@alert color='info' id='messages_infos_div'>
			<@button style='close' />
			<#list infos as info >
				<span class="icon"><@icon style='info-circle' /></span> ${info.message}<br />
			</#list>
		</@alert>
	</#if>
</#if>
<#if warnings??>
	<#if warnings?size &gt; 0 >
		<div class="${warnings_class}" id="messages_warnings_div" >
			<@aButton style='close' params='data-dismiss="alert"' href='#'>x</@aButton>
			<#list warnings as warning >
				<span class="icon"><@icon style='info-circle' /></span> ${warning.message} <br />
			</#list>
		</div>
	</#if>
</#if>
</#macro>
	
<#-- TABLE -->
<#-- class:  -->
<#macro table responsive=true condensed=true hover=true striped=false bordered=false narrow=false class='' id='' params=''>
	<#assign tableClass=class />
	<#if condensed> <#assign tableClass=tableClass + ' table-sm' /> </#if>
	<#if hover>     <#assign tableClass=tableClass + ' table-hover' /> </#if>
	<#if striped>   <#assign tableClass=tableClass + ' table-striped'   /> </#if>
	<#if bordered>  <#assign tableClass=tableClass + ' table-bordered'  /> </#if>
	<#if responsive>
	<div class="table-responsive-sm">
	</#if>
	<table class="table ${tableClass}" id="${id}"<#if params!=''> ${params}</#if>>
		<#nested>
	</table>
	<#if responsive>
	</div>
	</#if>
</#macro>

<#-- MACRO TR -->
<#macro tr>
	<tr>
    <#nested>
	</tr>
</#macro>

<#-- MACRO TH -->
<#macro th id='' class='' hide=[] showXs=true showSm=true showMd=true showLg=true showXl=true cols=0 xs=0 sm=0 md=0 lg=0 xl=0 flex=false params=''>
	<#local class += displaySettings(hide,'table-cell') />
	<#if cols!=0>
		<#local class += ' col-${cols}' />
	</#if>
	<th class="<#if class != ''>${class}</#if><#if flex> d-flex</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
		<#nested>
	</th>
</#macro>

<#-- MACRO TD -->
<#macro td id='' class='' hide=[] showXs=true showSm=true showMd=true showLg=true showXl=true cols=0 xs=0 sm=0 md=0 lg=0 xl=0 flex=false params=''>
	<#local class += displaySettings(hide,'table-cell') />
	<#if cols!=0>
		<#local class += ' col-${cols}' />
	</#if>
	<td class="<#if class != ''>${class}</#if><#if flex> d-flex</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
		<#nested>
	</td>
</#macro>


<#-- SORT -->
<#macro sort jsp_url attribute id="" >
<#if jsp_url?contains("?")>
	<#assign sort_url = jsp_url + "&amp;sorted_attribute_name=" + attribute + "&amp;asc_sort=" />
<#else>
	<#assign sort_url = jsp_url + "?sorted_attribute_name=" + attribute + "&amp;asc_sort=" />
</#if>
<@btnGroup ariaLabel='sortButton'>
	<@aButton color='default' size='sm' id='sort${id!}_${attribute!}' href='${sort_url}true#sort${id!}_${attribute!}' title='#i18n{portal.util.sort.asc}' buttonIcon='chevron-up' hideTitle=['all'] />
	<@aButton color='default' size='sm' href='${sort_url}false#sort${id!}_${attribute!}' title='#i18n{portal.util.sort.desc}' buttonIcon='chevron-down' hideTitle=['all'] />
</@btnGroup>
</#macro>

<#-- ICONS -->
<#-- Icons from FontAwesome -->
<#macro icon prefix='fa-' style='' class='' title='' id='' params=''>
<#if style='docker' || style = 'github' || style='gitlab' || style='java' || style='jira' || style='jenkins' || style = 'twitter' >
	<#local prefix = 'fab ' + prefix />
<#else>
	<#local prefix = 'fa ' + prefix />
</#if>
	<i class="${prefix}${style}<#if class!=''> ${class}</#if>" aria-hidden="true"<#if title!=''> title='${title}'</#if><#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>></i>
</#macro>

<#-- FORM -->
<#-- type: inline/horizontal/form -->
<#macro tform type='horizontal' class='' align='' hide=[] action='' method='post' name='' id='' role='form' params=''>
	<#assign formClass = alignmentSettings(align) + ' ' + class />
	<#switch type>
		<#case 'horizontal'>
		<#assign formClass += ' form-horizontal'>
		<#break>

		<#case 'inline'>
		<#assign formClass += ' form-inline'>
		<#break>
		
		<#default>
		<#assign formClass += ' form'>
	</#switch>

	<form class="<#if formClass!=''>${formClass?trim}</#if>"<#if id!=''> id="${id}"</#if><#if action!=''> action="${action}"</#if><#if method!=''> method="${method}"</#if><#if name!=''> name="${name}"</#if><#if role!=''> role="${role}"</#if><#if params!=''> ${params}</#if>>
		<#nested>
	</form>
</#macro>


<#-- FORM ELEMENT STRUCTURE 												  								-->
<#-- formStyle values: horizontal/empty/inline Default is horizontal 	-->
<#-- class: 						 								-->
<#-- groupStyle: success/error -->
<#macro formGroup formStyle='horizontal' class='' groupStyle='' rows=1 labelKey='' labelFor='' labelId='' helpKey='' id='' mandatory=false hideLabel=[] params=''>
<#assign mandatory = mandatory>
<#assign labelFor = labelFor>
<#assign labelId = labelId>
<#assign labelKey = labelKey>
<#assign hideLabel = hideLabel>
<#assign helpKey = helpKey>
<#if groupStyle = "success">
	<#local validation = "is-valid">
<#elseif groupStyle="error">
	<#local validation = "is-invalid">
</#if>
<div class="form-group<#if formStyle='horizontal'> row</#if><#if class!=''> ${class}<#/if><#if validation?? && validation!=''> ${validation}</#if></#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
<#local labelClass = '' />
<#local displayClass = displaySettings(hideLabel,'inline-flex') />
	<#if rows=1>
		<#if labelKey!='' && formStyle='horizontal'>
			<#local labelClass = "col-sm-12 col-lg-3 col-form-label">
			<#if displayClass?contains('d-none')>
				<#local divClass="col">
			<#else>	
				<#local divClass = "col-lg-6">
			</#if>
		<#elseif formStyle = 'inline'>
			<#local labelClass = 'sr-only'>
			<#local divClass = "mb-2 mr-sm-2">
		<#else>
				<#local divClass="col-sm-12 offset-lg-3 col-lg-3">
		</#if>
	<#else>
		<#local labelClass = "col-sm-12 col-form-label">
		<#local divClass = "col-sm-12">
	</#if>
	<#local labelClass = labelClass>
	<#if labelKey!=''>
		<@formLabel class=labelClass labelFor=labelFor labelId=labelId labelKey=labelKey hideLabel=hideLabel mandatory=mandatory />
	</#if>
	<#if formStyle !='inline'>
		<div class="${divClass}">
	</#if>
	<#nested>
	<#if helpKey!=''><small class="text-muted<#if formStyle!='inline'> form-text</#if>" <#if labelFor!=''>aria-describedby="${labelFor}"</#if>>${helpKey}</small></#if>
	<#if formStyle !='inline'>
		</div>
	</#if>
</div>
</#macro>

<#macro formField class=''>
<div class="form-row<#if class!=''> ${class}</#if>">
<#nested>
</div>
</#macro>

<#macro formLabel class='' labelFor='' labelId='' labelKey='' hideLabel=[] mandatory=true>
<#local labelDisplayClass = displaySettings(hideLabel,'') />
<label class="<#if class !=''>${class}</#if> ${labelDisplayClass}" for="${labelFor}" <#if labelId!=''> id="${labelId}"</#if><#if mandatory=true>ariaLabel="${labelKey} [#i18n{portal.users.modify_attribute.labelMandatory}]"</#if>>${labelKey}</label>
</#macro>

<#macro formHelp style='inline' class='' labelFor=''>
<small class="text-muted<#if style!='inline'> form-text</#if><#if class!=''> ${class}</#if>" <#if labelFor!=''>aria-describedby="${labelFor}"</#if>>
<#nested>
</small>
</#macro>

<#-- INPUT TEXT/TEXTAREA/SEARCH/PASSWORD/EMAIL/FILE 																					-->
<#-- type : text/textarea/password/email/file/number. Default is text 												-->
<#-- size: sm/lg/EMPTY for medium size 																												-->
<#-- incoming Bootstrap 4 size: form-control-sm/form-control-lg or empty for the normal size 	-->
<#-- pattern: [A-F][0-9]{5} 																																	-->
<#macro input name type='text' value='' class='' size='' inputSize=0 maxlength=0 placeHolder='' rows=4 cols=40 richtext=false tabIndex='' id='' disabled=false readonly=false pattern='' params='' title='' min=0 max=0>
	<#if type='textarea'>
		<textarea name="${name}" class="form-control<#if size!=''> form-control-${size}</#if><#if class!=''> ${class}</#if><#if richtext> richtext</#if>" rows="${rows}" cols="${cols}"<#if tabIndex!=''> tabindex="${tabIndex}"</#if><#if placeHolder!=''> placeholder="${placeHolder}"</#if><#if title!=''> title="${title}"</#if><#if disabled> disabled</#if><#if readonly> readonly</#if><#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if><#if pattern!=''>pattern=${pattern}</#if><#if mandatory?? && mandatory && !richtext> required</#if><#if labelFor?? && labelFor!='' && helpKey?? && helpKey!=''> aria-describedby="${labelFor}_help"</#if>><#nested></textarea>
	<#elseif type='text' || type='search' || type='password' || type='email' || type='file' || type='number' || type='date'>
		<input class="form-control<#if type='file'>-file</#if><#if size!=''> form-control-${size}</#if><#if class!=''> ${class}</#if>" name="${name}" type="${type}" value="${value}"<#if tabIndex!=''> tabindex="${tabIndex}"</#if><#if placeHolder!=''> placeholder="${placeHolder}<#if mandatory?? && mandatory> [#i18n{portal.users.modify_attribute.labelMandatory}]</#if>"</#if><#if title!=''> title="${title}"</#if><#if maxlength &gt; 0> maxlength="${maxlength}"</#if><#if inputSize!=0> size="${inputSize}"</#if><#if disabled> disabled</#if><#if readonly> readonly</#if><#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if><#if pattern!=''>pattern=${pattern}</#if><#if min!=0> min="${min}"</#if><#if max!=0> max="${max}"</#if><#if mandatory?? && mandatory> required</#if><#if labelFor?? && labelFor!='' && helpKey?? && helpKey!=''> aria-describedby="${labelFor}_help"</#if> />
	<#elseif type='hidden'>
		<input type="hidden" name="${name}" value="${value}" />
	<#else>
		<@icon style='warning' /> Type not supported
	</#if>
</#macro>

<#-- STATIC TEXT -->
<#-- Bootstrap colors: primary/secondary/success/info/warning/danger/light/black/muted/white/text-black-50/text-white-50 -->
<#macro staticText inForm=true color='' id='' params=''>
<p class="<#if inForm>form-control-plaintext</#if><#if color!=''> text-${color}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</p>
</#macro>

<#--- MACRO SELECT (TO REPLACE "COMBO" MACROS) --->
<#macro select name items='' default_value='' id=name class='' size='' sort=false multiple=0 params='' title='' tabIndex=0>
	<select id="${id}" name="${name}" class="form-control<#if size!=''> form-control-${size}</#if><#if class!=''> input-${class}</#if>" <#if (multiple &gt; 0)>multiple size="${multiple}"</#if><#if (tabIndex &gt; 0)> tabindex="${tabIndex}"</#if><#if params!=''> ${params}</#if><#if title!=''> title="${title}"</#if><#if mandatory?? && mandatory> required</#if>>
	<#if items?has_content>
		<#if sort=true>
			<#list items?sort_by("name") as item>
				<#if default_value="${item.code}">
					<option selected="selected" value="${item.code}" <#if !item.name?has_content>label="${i18n("portal.util.labelEmpty")}"</#if>>${item.name}</option>
				<#else>
					<option value="${item.code}" <#if !item.name?has_content>label="${i18n("portal.util.labelEmpty")}"</#if>>${item.name}</option>
				</#if>
			</#list>
		<#else>
			<#list items as item>
				<#if default_value="${item.code}">
					<option selected="selected" value="${item.code}" <#if !item.name?has_content>label="${i18n("portal.util.labelEmpty")}"</#if>>${item.name}</option>
				<#else>
					<option value="${item.code}" <#if !item.name?has_content>label="${i18n("portal.util.labelEmpty")}"</#if>>${item.name}</option>
				</#if>
			</#list>
		</#if>
	<#else>
		<#nested>
	</#if>
	</select>
</#macro>

<#-- CHECKBOX 																							-->
<#-- orientation: vertical/horizontal. Default is vertical 	-->
<#-- TODO  																									-->
<#macro checkBox name id labelKey='' labelFor='' orientation='vertical' value='' tabIndex='' title='' disabled=false readonly=false checked=false params='' mandatory=false>
<#if labelFor = ''><#local labelFor = id /></#if>
<#if orientation='vertical'>
<div class="checkbox">
</#if>
	<label<#if orientation='horizontal'> class="checkbox-inline"</#if><#if labelFor!=''> for="${labelFor}"</#if>>
	<input type="checkbox" id="${id}" name="${name}"<#if value!=''> value="${value}"</#if><#if tabIndex!=''> tabindex="${tabIndex}"</#if><#if checked> checked</#if><#if disabled> disabled</#if><#if readonly> readonly</#if><#if params!=''> ${params}</#if><#if mandatory> required</#if> />
		<#if labelKey!=''>
			${labelKey}
		<#else>
			&#160;
		</#if>
	</label>
<#if orientation='vertical'></div></#if>
</#macro>

<#-- RADIO BUTTON -->
<#-- orientation: vertical/horizontal. Default is vertical -->
<#macro radioButton name id='' value='' labelKey='' labelFor='' orientation='vertical' tabIndex='' title='' disabled=false readonly=false checked=false params=''>
	<#if orientation='vertical'>
		<div class="radio">
	</#if>
			<label<#if orientation='horizontal'> class="radio-inline"</#if>>
				<input type="radio" id="${id}" name="${name}"<#if value!=''> value="${value}"</#if><#if tabIndex!=''> tabindex="${tabIndex}"</#if><#if checked> checked</#if><#if disabled> disabled</#if><#if readonly> readonly</#if><#if mandatory?? && mandatory> required</#if><#if params!=''> ${params}</#if> />
			<#if labelKey!=''>
					${labelKey}
			<#else>
					&#160;
			</#if>
			</label>
<#if orientation='vertical'></div></#if>
</#macro>


<#-- INPUT-GROUP -->
<#-- size: sm/lg/no size-->
<#macro inputGroup size='' class='' id='' params=''>
	<div class="input-group<#if size!=''> input-group-${size}</#if><#if class!=''> ${class}</#if>" <#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
		<#nested>
	</div>
</#macro>

<#macro inputGroupItem pos='append' type='btn' id='' params=''>
<#-- pos: append / prepend | Default append -->
<#-- type: btn/text. default is btn	-->

<div class="input-group-${pos}">
<#if type = 'text'>
	<div class="input-group-${type}"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
</#if>
		<#nested>
<#if type = 'text'>
	</div>
</#if>
</div>
</#macro>

<#-- DROPDOWN MENU -->
<#-- class: dropdown-menu-right -->
<#-- Expected content : <li><a>Your link here</a></li> -->
<#macro dropdownMenu class='' id='' params=''>
	<ul class="dropdown-menu ${class}"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
		<#nested>
	</ul>
</#macro>

<#-- ROW -->
<#macro row class='' id='' params=''>
	<div class="row<#if class!=''> ${class}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
		<#nested>
	</div>
</#macro>

<#-- COLUMNS -->
<#-- cols = col-xs- (<544px)/col-sm- (>=544px)/col-md- (>=768px)/col-lg- (>=992px)/col-xl- (>=1200px) -->
<#macro columns offsetXs=0 offsetSm=0 offsetMd=0 offsetLg=0 offsetXl=0 pushXs=0 pushSm=0 pushMd=0 pushLg=0 pushXl=0 pullXs=0 pullSm=0 pullMd=0 pullLg=0 pullXl=0 xs=12 sm=0 md=0 lg=0 xl=0 id='' class='' params=''>
<#if xs=12 && sm=0 && md=0 && lg=0 && xl=0>
<div class="col<#if class!=''> ${class}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
<#else>
<div class="<#if sm!=0> col-sm-${sm}</#if><#if md!=0> col-md-${md}</#if><#if lg!=0> col-lg-${lg}</#if><#if xl!=0> col-xl-${xl}</#if><#if offsetXs!=0> col-xs-offset-${offsetXs}</#if><#if offsetSm!=0> col-sm-offset-${offsetSm}</#if><#if offsetMd!=0> col-md-offset-${offsetMd}</#if><#if offsetLg!=0> col-lg-offset-${offsetLg}</#if><#if offsetXl!=0> col-xl-offset-${offsetXl}</#if><#if pushXs!=0> col-xs-push-${pushXs}</#if><#if pushSm!=0> col-sm-push-${pushSm}</#if><#if pushMd!=0> col-md-push-${pushMd}</#if><#if pushLg!=0> col-lg-push-${pushLg}</#if><#if pushXl!=0> col-xl-push-${pushXl}</#if><#if pullXs!=0> col-xs-pull-${pullXs}</#if><#if pullSm!=0> col-sm-pull-${pullSm}</#if><#if pullMd!=0> col-md-pull-${pullMd}</#if><#if pullLg!=0> col-lg-pull-${pullLg}</#if><#if pullXl!=0> col-xl-pull-${pullXl}</#if><#if class!=''> ${class}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
</#if>
	<#nested>
</div>
</#macro>

<#-- LISTS -->
<#macro ul id='' params='' class='' hide=[] align=''>
	<#local class += alignmentSettings(align) />
	<#local class += displaySettings(hide,'block') />
	<ul<#if class!=''> class="${class}"</#if><#if params!=''> ${params}</#if><#if id!=''> ${id}</#if>>
		<#nested>
	</ul>
</#macro>

<#macro li id='' params='' class='' hide=[] align=''>
		<#local class += alignmentSettings(align) />
		<#local class += displaySettings(hide,'block') />
		<li<#if class!=''> class="${class}"</#if><#if params!=''> ${params}</#if><#if id!=''> ${id}</#if>>
			<#nested>
		</li>
</#macro>

<#-- PARAGRAPH -->
<#macro p id='' params='' class='' hide=[] align=''>
	<#local class += alignmentSettings(align) />
	<#local class += displaySettings(hide,'block') />
	<p<#if class!=''> class="${class}"</#if><#if params!=''> ${params}</#if><#if id!=''> ${id}</#if>>
		<#nested>
	</p>
</#macro>

<#-- SPAN -->
<#macro span id='' params='' class='' hide=[] align=''>
	<#local class += alignmentSettings(align) />
	<#local class += displaySettings(hide,'inline-flex') />
	<span<#if class!=''> class="${class}"</#if><#if params!=''> ${params}</#if><#if id!=''> ${id}</#if>>
		<#nested>
	</span>
</#macro>

<#-- PRE -->
<#macro pre id='' params='' class='' hide=[] align=''>
	<#local class += alignmentSettings(align) />
	<#local class += displaySettings(hide,'block') />
	<pre<#if class!=''> class="${class}"</#if><#if params!=''> ${params}</#if><#if id!=''> ${id}</#if> style="white-space:nowrap;">
		<#nested>
	</pre>
</#macro>

<#-- TABS -->

<#-- Tab Container -->
<#macro tabs color='' id='' params=''>
	<div class="<#if color!=''> ${color}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
		<#nested>
	</div>
</#macro>

<#-- Tabs List -->
<#-- type: tabs/tabs nav-justified/pills/pills nav-stacked/pills nav-justified -->
<#macro tabList type='tabs' vertical=false id='' params='' color=''>
		<ul class="nav nav-${type}<#if vertical> flex-column mb-3</#if>" style="margin-bottom:1.5rem;"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if> role="tablist">
			<#nested>
		</ul>
</#macro>

<#-- Tabs -->
<#-- type:  -->
<#macro tabLink class='' hide=[] id='' active=false href='' title='' tabIcon='' params=''>
		<li class="nav-item"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
		<#local tabLinkClass = class + ' nav-link' />
		<#if active><#local tabLinkClass += ' active' /></#if>
		<#local tabLinkSettings = 'role="tab" aria-expanded="${active?c}" aria-controls="${href?remove_beginning("#")}"' />
		<#if href?contains('#') && href?contains('.jsp') == false>
			<#local tabLinkSettings += ' data-toggle="tab"' />
			<#local tabLinkId = '${href?remove_beginning("#")}-tab' />
		<#else>
			<#local tabLinkId = href?keep_after_last('/')?keep_before('.')?lower_case />
		</#if>
			<@link class=tabLinkClass?trim href=href id=tabLinkId title=title params=tabLinkSettings>
				<#if tabIcon!=''><@icon style=tabIcon /></#if> ${title}
			</@link>
		</li>
</#macro>

<#-- TAB Content -->
<#macro tabContent id='' params=''>
		<div class="tab-content"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
			<#nested>
		</div>
</#macro>

<#-- Tab Panel BS4 -->
<#macro tabPanel id params='' active=false>
		<div class="tab-pane fade<#if active> show active</#if>" role="tabpanel" id="${id}" aria-labelledby="${id}-tab"<#if params!=''> ${params}</#if>>
			<#nested>
		</div>
</#macro>


<#-- ACCORDION --> 
<#-- The accordionContainer is the container for accordionPanel, which itself is the container for accordionHeader and accordionBody -->
<#-- The childId argument in accordionPanel is meant to be used in the two sub-macros: accordionHeader and accordionBody -->
<#macro accordionContainer id params=''>
	<div class="accordion" id="${id}"<#if params!=''> ${params}</#if>>
		<#assign parentId = id>
		<#nested>
	</div>
</#macro>

<#macro accordionPanel color='' collapsed=true childId='' id='' params=''>
	<div class="card<#if color!=''> bg-${color}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
		<#if collapsed>
			<#assign aClass = 'collapsed'>
			<#assign expanded = 'false'>
			<#assign childClass = 'collapse'>
		<#else>
			<#assign aClass = ''>
			<#assign expanded = 'true'>
			<#assign childClass = 'collapse show'>
		</#if>
		<#assign childId = childId>
		<#nested>
	</div>
</#macro>

<#-- ACCORDION ELEMENT --> 
<#-- The boxTools parameter is unused, kept for backwards compatibility -->
<#macro accordionHeader id='' title='' parentId=parentId childId=childId boxTools=false params='' headerIcon='' >
<div class="card-header" id="${childId}-header"<#if params!=''> ${params}</#if>>
	<h2 class="mb-0">
		<button class="btn btn-link<#if aClass!=''> ${aClass}</#if>" type="button" data-toggle="collapse" data-target="#${childId}" aria-expanded="${expanded}" aria-controls="${childId}">
			<#if headerIcon!=''><@icon style=headerIcon /></#if> &nbsp;
			${title}
	</h2>
	<#local nested><#nested></#local>
	<#if nested?has_content>
	<div class="box-tools">
		${nested}
	</div>
	</#if>
</div>
</#macro>

<#macro accordionBody id=childId class=childClass expanded=expanded params=''>
<div id="${id}" class="${class}" aria-labelledby="${childId}-header" data-parent="#${parentId}" <#if params!=''> ${params}</#if>>
	<@boxBody>
		<#nested>
	</@boxBody>
</div>
</#macro>

<#macro progressBar description='' id='' params=''>
<div class="progress"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<div id="progressbar" class="progress-bar progress-bar-striped" role="progressbar">
		<div id="complexity">0%</div>
	</div>
</div>
<#if description!=''>
	<span class="progress-description">${description}</span>
</#if>
</#macro>

<#macro progress color='primary' id='' params='' value=0 min=0 max=100 text=''>
<div class="progress"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<div id="progressbar" class="progress-bar bg-${color}" role="progressbar" style="width: ${value}%;" aria-valuenow="${value}" aria-valuemin="${min}" aria-valuemax="${max}">
        <#if text=''>${value}%<#else>${text}</#if>
	</div>
</div>
</#macro>



<#-- INFO-BOX AdminTLE (widget) -->
<#-- color: only for the left side showing the icon. -->
<#-- bgColor: for the right side containing the text -->
<#macro infoBox color='' boxText='' boxIcon='' boxNumber='' unit='' bgColor='' progressBar='' progressDescription='' id='' params=''>
<div class="info-box<#if bgColor!=''> ${bgColor}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<span class="info-box-icon<#if color!=''> ${color}</#if>"><@icon style=boxIcon /></span>
	<div class="info-box-content">
		<span class="info-box-text">${boxText}</span>
		<span class="info-box-number">${boxNumber?string(",000")}<#if unit!=''> <small>${unit}</small></#if></span>
		<#if bgColor!='' && progressBar!=''>
		<div class="progress">
			<div class="progress-bar" style="width: ${progressBar}%"></div>
		</div>
		</#if>
		<#if progressDescription!=''>
		<span class="progress-description">${progressDescription}</span>
		</#if>
	</div>
</div>
</#macro>

<#-- TAG -->
<#-- color: default/primary/success/info/warning/danger/ -->
<#macro tag color='default' size='' title='' tagIcon='' id='' params=''>
	
	<span class="badge badge-${color}"<#if title!=''> title='${title}'</#if><#if id!=''>id='${id}'</#if><#if params!=''>${params}</#if>>
		<#if tagIcon !=''>
		<@icon style=tagIcon />
		</#if>
		<#nested>
	</span>
</#macro>

<#-- BUTTON -->
<#-- bootstrap 4 : size: sm for small buttons/empty for medium buttons/lg for large buttons -->
<#-- color: default[bootstrap4 : secondary]/primary/success/warning/danger/info -->
<#-- color (upcoming bootstrap 4): btn-outline-default/btn-outline-primary/btn-outline-success/btn-outline-warning/btn-outline-danger/btn-outline-info/ -->
<#-- style: btn-block/btn-flat/close/navbar-toggle/collapsed... -->
<#-- type: button/submit/reset -->
<#-- params: data-toggle/data-target/data-dismiss... -->
<#-- buttonIcon: icon name ex: info/check/comment/envelope... -->
<#-- iconPosition: left/right -->
<#-- cancel: switch to true for a cancellation form button. Adds the "formnovalidate" attribute to the button, as well as the right class -->
<#-- form: contains the form ID if the button is outside of the form -->
<#macro button name='' id='' type='button' size='' color='' style='' class='' params='' value='' title='' tabIndex='' hideTitle=[] showTitle=true showTitleXs=true showTitleSm=true showTitleMd=true showTitleLg=true showTitleXl=true buttonIcon='' disabled=false iconPosition='left' dropdownMenu=false cancel=false form=''>
	<#-- Visibility of button title -->
	<#local displayTitleClass = displaySettings(hideTitle,'inline') />
	<#if cancel || color = 'default'>
		<#local buttonColor = 'secondary' />
	<#elseif !cancel && color=''>
		<#local buttonColor = 'primary' />
	<#else>
		<#local buttonColor = color />
	</#if>
	<#if style='card-control'>
		<#local style='text-right btn-link' />
	</#if>

	<#if size = 'xs'>
		<#local size = 'sm' />
	</#if>
	
	<#if dropdownMenu>
		<div class="btn-group">
	</#if>
		<button class="<#if style!='close'>btn</#if><#if size!='' && style!='card-control'> btn-${size}</#if><#if buttonColor!='' && style!='card-control'> btn-${buttonColor}</#if><#if style!=''> ${style}</#if><#if dropdownMenu> dropdown-toggle</#if><#if class!=''> ${class}</#if>" type="${type}"<#if title!=''> title="${title}"</#if><#if name!=''> name="${name}"</#if><#if id!=''> id="${id}"</#if><#if value!=''> value="${value}"</#if><#if params!=''> ${params}</#if><#if disabled> disabled</#if><#if dropdownMenu> data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"</#if><#if cancel> formnovalidate</#if><#if form!=''> form="${form}"</#if>>
			<#if buttonIcon!='' && iconPosition='left'><@icon style=buttonIcon /></#if>
			<#if displayTitleClass!='' && style!='card-control'><span class="${displayTitleClass}"></#if>${title}<#if displayTitleClass!='' && style!='card-control'></span></#if>
			<#if buttonIcon!='' && iconPosition='right'><@icon style=buttonIcon /></#if>
		</button>
	<#if dropdownMenu>
			<div class="dropdown-menu"<#if id!=''> aria-labelledby="${id}"</#if>>
				<#nested>
			</div>
		</div>
	</#if>
</#macro>

<#-- A BUTTON (LINK STYLED AS A BUTTON) -->
<#-- size: sm/lg/or EMPTY for medium size-->
<#-- color: default/primary/success/warning/danger/info/ -->
<#-- style: btn-block/btn-flat/disabled/btn-app -->
<#-- icon: icon name ex: info/check/comment/envelope... -->
<#-- ShowTitleXs is UNUSED in Bootstrap 4. -->
<#macro aButton name='' id='' href='' size='' color='primary' style='btn' class='' params='' title='' tabIndex='' hideTitle=[] showTitle=true showTitleXs=true showTitleSm=true showTitleMd=true showTitleLg=true showTitleXl=true buttonIcon='' disabled=false iconPosition='left' dropdownMenu=false>
<#local displayTitleClass = displaySettings(hideTitle,'inline') />
	<#if !showTitleXs><#local showTitleSm = false></#if>
	<#-- Visibility of button title -->
	<#-- The media queries effect screen widths with the given breakpoint or larger, therefore if the value for either showTitleMd/Lg/Xl is FALSE, values for smaller screen widths should be set to FALSE as well. -->
	<#if !showTitleMd><#local showTitleSm = false></#if>
	<#if !showTitleLg><#local showTitleSm = false showTitleMd = false></#if>
	<#if !showTitleXl><#local showTitleSm = false showTitleMd = false showTitleLg = false></#if>
	
	<#local showTitleClass = '' />
	<#if !showTitle><#local showTitleClass = 'sr-only' /></#if>
	<#if !showTitleXs || !showTitleSm || !showTitleMd || !showTitleLg || !showTitleXl>
		<#local showTitleClass = 'd-none' />
	</#if>
	
	<#if !showTitleSm || !showTitleXs><#local showTitleClass = showTitleClass + ' d-md-inline-block' />
	<#elseif !showTitleMd && !showTitleSm><#local showTitleClass = showTitleClass + ' d-lg-inline-block' />
	<#elseif !showTitleLg && !showTitleMd && !showTitleSm><#local showTitleClass = showTitleClass + ' d-xl-inline-block' />
	<#elseif !showTitleXl && !showTitleLg && !showTitleMd && !showTitleSm><#local showTitleClass = showTitleClass />
	<#else></#if>
	
	<#if size = 'xs'>
		<#local size = 'sm' />
	</#if>
	
	<#if dropdownMenu>
		<div class="btn-group">
	</#if>
	
	<a class="${style} <#if size!=''> btn-${size}</#if><#if color!=''> btn-${color}</#if><#if class!=''> ${class}</#if>"<#if name!=''> name="${name}"</#if><#if id!=''> id="${id}"</#if> href="${href}" title="${title}"<#if params!=''> ${params}</#if><#if disabled> disabled</#if><#if dropdownMenu> data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"</#if>>
		<#if buttonIcon!='' && iconPosition='left'><@icon style=buttonIcon /></#if>
		<span class="${displayTitleClass}">${title}</span>
		<#if buttonIcon!='' && iconPosition='right'><@icon style=buttonIcon /></#if>
		<#if !dropdownMenu>
		<#nested>
		</#if>
	</a>
		<#if dropdownMenu>
		<div class="dropdown-menu"<#if id!=''> id="${id}" aria-labelledby="${id}"</#if>>
			<#nested>
		</div>
		</div>
		</#if>
</#macro>

<#macro dropdownItem>
			<a class="dropdown-item"><#nested></a>
</#macro>

<#-- BTN TOOLBAR -->
<#macro btnToolbar id='' params='' ariaLabel=''>
<div class="btn-toolbar" role="toolbar"<#if ariaLabel!=''> aria-label="${ariaLabel}"</#if><#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
<style type="text/css">
.btn-toolbar > div:not(:last-of-type) {margin-right:0.2rem;}
</style>
	<#nested>
</div>
</#macro>

<#-- BTN GROUP -->
<#-- size: sm/empty/lg -->
<#-- align: left/center/right -->
<#macro btnGroup align='' size='' class='' id='' params='' ariaLabel='' hide=[]>
<#local displayClass = displaySettings(hide,'inline-flex') />
<#local class = class + alignmentSettings(align) />
<div class="btn-group<#if size!=''> btn-group-${size}</#if> align-items-baseline<#if class!=''> ${class}</#if><#if displayClass !=''> ${displayClass}</#if>" role="group"<#if ariaLabel!=''> aria-label="${ariaLabel}"</#if><#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#-- Radio button/Checkbox as buttons (to use with btnGroup)  -->
<#-- type: radio/checkbox -->
<#macro btnGroupRadioCheckbox type='checkbox' color='primary' size='' name='' id='' params='' ariaLabel='' labelFor='' labelKey='' labelParams='' tabIndex='' value='' checked=false>
<label class="btn btn-${color}<#if size!=''> btn-${size}</#if>" for="${labelFor}"<#if labelParams!=''> ${labelParams}</#if>>
<input type="${type}" name="${name}" id="${id}" autocomplete="off"<#if value!=''> value="${value}"</#if><#if params!=''> ${params}</#if><#if tabIndex!=''> tabindex="${tabIndex}"</#if><#if checked> checked</#if> /><#if labelKey!=''>${labelKey}</#if>
</label>
</#macro>

<#-- Simple links a href, anchors -->
<#macro link href='' class='' id='' name='' title='' alt='' target='' params=''>
	<a href="${href}"<#if class!=''> class="${class}"</#if><#if id!=''> id="${id}"</#if><#if name!=''> name="${name}"</#if><#if target!=''> target="${target}"</#if><#if title!=''> title="${title}"</#if><#if alt!=''> alt="${alt}"</#if><#if params!=''> ${params}</#if>>
		<#nested>
	</a>
</#macro>

<#-- MODAL -->
<#-- bgColor: modal-default/modal-primary/modal-info/modal-warning/modal-danger -->
<#macro modal id params='' bgColor=''>
<div class="modal ${bgColor} fade" tabindex="-1" role="dialog" id="${id}" data-toggle="modal"<#if params!=''> ${params}</#if>>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<#nested>
		</div>
	</div>
</div>
</#macro>

<#macro modalHeader titleLevel='h4' modalTitle='' id='' params=''>
<div class="modal-header"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<${titleLevel} class="modal-title">${modalTitle}</${titleLevel}>
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
</div>
</#macro>

<#macro modalBody id='' params=''>
<div class="modal-body"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#macro modalFooter id='' params=''>
<div class="modal-footer"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#-- BREADCRUMBS -->
<#macro breadcrumbs id='' params=''>
<ol class="breadcrumb"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</ol>
</#macro>

<#-- CALLOUT -->
<#-- AdminLTE classes: info/warning/danger/success -->
<#macro callOut color='' titleLevel='h3' title='' callOutIcon='' id='' params=''>
<div class="callout callout-${color}"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#if title!=''><${titleLevel}><@icon style=callOutIcon /> ${title}</${titleLevel}></#if>
	<#nested>
</div>
</#macro>

<#-- ALERT -->
<#-- classes: alert-success/alert-info/alert-warning/alert-danger + alert-dismissible -->
<#-- color: primary/success/info/warning/danger -->
<#macro alert class='' color='' titleLevel='h3' title='' iconTitle='' dismissible=false id='' params=''>
<div class="alert<#if class!=''> ${class}</#if><#if color!=''> alert-${color}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#if dismissible>
		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">
			&times;
		</button>
	</#if>
	<#if title!=''>
	<${titleLevel}>
		<#if iconTitle!=''><@icon style=iconTitle /></#if>
		${title}
	</${titleLevel}>
	</#if>
	<#nested>
</div>
</#macro>


<#---------------------------------------------------------->
<#-- Card as Box 																				-->
<#-- color: default/primary/info/success/warning/danger 	-->
<#-- style: solid (no top border) 												-->
<#-- collapsed: true/false 																-->
<#---------------------------------------------------------->
<#macro box color='' id='' style='' class='' params='' collapsed=false>
<div class="card m-2 bg-dark<#if style!=''> text-${style}</#if><#if class!=''> ${class}</#if><#if collapsed> collapsed-box</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#-- The boxTools parameter is unused, kept for backwards compatibility -->
<#macro boxHeader title='' i18nTitleKey='' hideTitle=[] showTitle=true id='' params='' boxTools=false titleLevel='h5'>
<div class="card-header text-white d-flex justify-content-between"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
<${titleLevel} class="box-title<#if showTitle=false> sr-only</#if>"><#if title!=''>${title}</#if><#if i18nTitleKey!=''>#i18n{${i18nTitleKey}}</#if></${titleLevel}>
	<#local nested><#nested></#local>
	<#if nested?has_content>
	<div class="d-flex justify-content-center">
		<style type="text/css">
			div.card-header > div.d-flex > form:last-of-type {margin-left:0.5rem;}
		</style>
		<#nested>
	</div>
	</#if>
</div>
</#macro>

<#macro boxBody class='' id='' params=''>
<div class="card-body bg-white<#if class!=''> ${class}</#if>" style="border-radius:0 0 3px 3px;"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#macro boxFooter class='' id='' params=''>
<div class="card-footer<#if class!=''> ${class}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>
<#---------------------------------------->

<#-- color: Bootstrap -->
<#-- unit: %,... -->
<#macro smallBox color='' title='' text='' boxIcon='' titleLevel='h5' unit='' url='' urlText='' id='' params='' fontSize='40px'>
<div class="card m-2 <#if color!=''> bg-${color}</#if>"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<div class="card-body">
		<#if url!=''>	<a class="card-link<#if color!=''> text-white</#if>" href="${url}"></#if>
		<${titleLevel} class="card-title"><@icon style=boxIcon /> 
		<#if unit!=''> ${unit}</#if></${titleLevel}>
		<#if url!=''></a></#if>
		<h3 class="card-text "> ${text} <span class="font-weight-bold">${title}</span></h3>
	</p>
	</div>
</div>
</#macro>

<#-- AdminLTE Error Page -->
<#-- Error Type: 500,404... -->
<#-- Color: primary/blue/navy/aqua/teal/green/orange/yellow/red/purple/maroon/gray/black... -->
<#macro errorPage color='' errorType='' id='' params=''>
<div class="error-page"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<h2 class="headline text-${color}">${errorType}</h2>
	<div class="error-content">
		<h3>
			<@icon style='warning' class='text-${color}' />
			<#if errorType=='404'>
				#i18n{portal.util.error404.title}
			<#elseif errorType='500'>
				#i18n{portal.util.error500.title}
			<#else>...
			</#if>
		</h3>
		<p>
			<#if errorType=='404'>
				#i18n{portal.util.error404.text} 
			<#elseif errorType='500'>
				#i18n{portal.util.error500.text} 
			<#else>...
			</#if>
		</p>
		<@aButton href='' size='' color='bg-${color}' style='btn-flat'>
			<@icon style='home' />
			#i18n{portal.util.labelBackHome}
		</@aButton>
	</div>
</div>
</#macro>

<#-- CONTEXTUAL BACKGROUND P-->
<#-- Bootstrap colors: primary/success/info/warning/danger -->
<#-- AdminTLE colors: gray/gray-light/black/red/yellow/aqua/blue/light-blue/green/navy/teal/olive/lime/orange/fuchsia/purple/maroon -->
<#macro coloredBg color='' type='p' id='' params=''>
<${type} class="bg-${color}"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</${type}>
</#macro>

<#macro listGroup id='' params=''>
<ul class="list-group"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</ul>
</#macro>

<#macro listGroupItem id='' params=''>
<li class="list-group-item list-group-item-action"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</li>
</#macro>

<#macro unstyledList id='' params=''>
<ul class="unstyled"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#assign liClass = "margin">
	<#nested>
</ul>
</#macro>

<#-- DROPDOWN MENU LIST -->
<#macro dropdownList id='' params=''>
<div class="dropdown-menu"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>
	<#nested>
</div>
</#macro>

<#macro dropdownItem class='' href='' title='' id='' params=''>
	<a href="${href}" class="dropdown-item<#if class!=''> ${class}</#if>" title="${title}"<#if id!=''> id="${id}"</#if><#if params!=''> ${params}</#if>>${title}</a>
</#macro>

<#-- CARDS -->
<#macro card header=false headerTitle='' headerIcon=false headerTitleIcon=''>
<div class="card">
	<#if header><div class="card-header"><#if headerIcon><@icon style='${headerTitleIcon}' />&#160;</#if>${headerTitle}</div></#if>
	<div class="card-body">
		<#nested>
	</div>
</div>
</#macro>

<#-- FUNCTION: DISPLAY -->
<#-- This function returns a "visible" or "hidden" class for any component -->
<#-- breakpoints: "all" || "xs"/"sm"/"md"/"lg"/"xl" -->
<#-- display: inline/inline-block/block/table/table-cell/table-row/flex/inline-flex -->
<#function displaySettings breakPoints=[] display=''>
	<#local breakPointsOrdered = [] />
	<#if breakPoints?seq_contains('all')>
		<#local breakPointsOrdered += ['all'] />
	</#if>
	<#if breakPoints?seq_contains('xs')>
		<#local breakPointsOrdered += ['xs'] />
	</#if>
	<#if breakPoints?seq_contains('sm')>
		<#local breakPointsOrdered += ['sm'] />
	</#if>
	<#if breakPoints?seq_contains('md')>
		<#local breakPointsOrdered += ['md'] />
	</#if>
	<#if breakPoints?seq_contains('lg')>
		<#local breakPointsOrdered += ['lg'] />
	</#if>
	<#if breakPoints?seq_contains('xl')>
		<#local breakPointsOrdered += ['xl'] />
	</#if>
	<#local displayClass = '' />
	<#if breakPointsOrdered?? && breakPointsOrdered?size &gt; 0>
		<#list breakPointsOrdered as breakPoint>
			<#if breakPoint = 'xs' || breakPoint = 'all'>
				<#local displayClass += 'd-none' />
				<#if breakPoint = 'xs'>
					<#if !breakPointsOrdered?seq_contains('sm')>
						<#local displayClass += ' d-md-${display}' />
					</#if>
				</#if>
			<#elseif breakPoint = 'sm' || breakPoint = 'md' || breakPoint = 'lg' || breakPoint = 'xl'>
				<#if breakPoint = 'sm'>
					<#if displayClass = ''>
						<#local displayClass += ' d-' + breakPoint + '-none' />
					<#elseif displayClass = 'd-none'>
						<#local displayClass += ' d-md-${display}' />
					</#if>
				<#elseif breakPoint = 'md'>
					<#if !breakPointsOrdered?seq_contains('sm')>
						<#local displayClass += ' d-' + breakPoint + '-none' />
					</#if>
					<#if !breakPointsOrdered?seq_contains('lg')>
						<#local displayClass += ' d-lg-${display}' />
					</#if>
				<#elseif breakPoint = 'lg'>
					<#if !breakPointsOrdered?contains('md')>
						<#local displayClass += ' d-' + breakPoint + '-none' />
					</#if>
					<#local displayClass += ' d-xl-${display}' />
				<#elseif breakPoint = 'xl'>
					<#if !breakPointsOrdered?seq_contains('lg')>
						<#local displayClass += ' d-' + breakPoint + '-none' />
					</#if>
				</#if>
			<#else>
				<#local displayClass += ' undefined_breakpoint' />
			</#if>
		</#list>
	</#if>
	<#return displayClass?trim>
</#function>

<#function alignmentSettings align=''>
	<#local x = ''>
	<#if align !=''>
		<#if align = 'left'>
			<#local x = 'float-left' />
		<#elseif align = 'right'>
			<#local x = 'float-right' />
		<#elseif align = 'center'>
			<#local x = 'mx-auto' />
		</#if>
	</#if>
	<#return x>
</#function>

<#-- -------------------------------------------------
-- MACRO ADMIN STRUCTURE - HEADER + NAVBAR + FOOTER -- 
-------------------------------------------------- -->
<#-- MACRO adminHeader -->
<#macro adminHeader site_name=site_name>
<body class="d-flex flex-column vh-100">
	<div class="skipnav"><a href="#main">allez au contenu principal</a></div>
	<h1 id="top" class="sr-only sr-only-focusable">Haut de page</h1>
	<header class="main-header" role="banner">
		<!-- <nav class="navbar navbar-expand-md navbar-fixed-top bg-primary" role="navigation"> -->
	  <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
			<a class="navbar-brand" href="jsp/site/Portal.jsp" title="#i18n{portal.users.admin_header.title.viewSite} ${site_name}" target="_blank" >
				<img src="#dskey{portal.site.site_property.logo_url}" height="30" class="d-inline-block align-top" aria-hidden="true" title="#i18n{portal.users.admin_header.title.viewSite} ${site_name}" alt="${site_name}">
				<#if site_name?length &gt; 18> ${site_name?substring(0,16)}... <#else> ${site_name}</#if>
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbar-collapse">
				<ul class="navbar-nav mr-auto">
				<#list feature_group_list as feature_group>
				  <#if feature_group.features?size &gt; 1>
					 	<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" id="dLabel${feature_group.id}Header" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" href="${admin_url}#${feature_group.id}">
								${feature_group.label}
							</a>
					   <div class="dropdown-menu" aria-labelledby="dLabel${feature_group.id}Header">
						 	<#list feature_group.features as feature>
								<#if !feature.externalFeature>
									<a class="dropdown-item" href="${feature.url}?plugin_name=${feature.pluginName}">${feature.name}</a>
								<#else>
									<a class="dropdown-item" href="${feature.url}">
										<#if feature.iconUrl?has_content><i class="${feature.iconUrl}"></i></#if> ${feature.name}
									</a>
								</#if>
						 	</#list>
							</div>
					 	</li>
				  <#else>
					 	<#list feature_group.features as feature>
					  	<li class="nav-item">
						  <#if !feature.externalFeature>
								<a class="nav-link" href="${feature.url}?plugin_name=${feature.pluginName}">${feature.name}</a>
						  <#else>
								<a class="nav-link" href="${feature.url}"><#if feature.iconUrl?has_content><i class="${feature.iconUrl}"></i></#if>${feature.name}</a>
						  </#if>
							</li>
					   </#list>
					 </#if>
			   </#list>
			  </ul>
			  <ul class="nav navbar-nav user">
					<li class="nav-item home">
						<a class="nav-link" href="${admin_url}" title="#i18n{portal.users.admin_header.homePage}">
							<i class="fas fa-home"></i>
						</a>
					</li>
                    <#if user.userLevel == 0>
                    <li class="nav-item home">
                        <a class="nav-link" href="jsp/admin/AdminTechnicalMenu.jsp" title="#i18n{portal.admindashboard.view_dashboards.title}">
                              <i class="fa fa-cog"></i>
                        </a>
                    </li>
                    </#if>
					<li class="nav-item dropdown user-menu">
						<a href="${admin_url}#user-menu" class="nav-link dropdown-toggle" data-toggle="dropdown" id="dLabelUserHeader">
							<#if adminAvatar> 
								<img src="servlet/plugins/adminavatar/avatar?id_user=${user.userId}" height="32px" class="d-inline-block align-top rounded" aria-hidden="true" alt="User's avatar"> 
							<#else> 
								<img src="#dskey{portal.site.site_property.avatar_default}" height="32px" class="d-inline-block align-top rounded-pill" aria-hidden="true"  alt="User's avatar"> 
							</#if>     
							${dashboard_zone_4!}
						</a>
						<div class="dropdown-menu"  role="menu" aria-labelledby="dLabelUserHeader">
							<#if userMenuItems?has_content>   
								<#list userMenuItems as item>
										${item.content}
								</#list>
							</#if>
						</div>
					</li>
					<#if admin_logout_url?has_content>
						<li class="nav-item">
							<a class="nav-link" href="${admin_logout_url}" title="#i18n{portal.users.admin_header.deconnectionLink}">
								<i class="fa fa-power-off fa-fw"></i>
							</a>
						</li>
					</#if>
		  </ul>
		</div>
	</nav>
</header>
<!-- Begin page content -->
<main role="main" class="flex-shrink-0">
 	<!-- Close in footer -->
</#macro>

<#-- MACRO adminFooter -->
<#macro adminFooter >
	<!-- end content section -->
</main>
<!-- footer menu -->
<footer class="footer mt-auto py-3">
	<div class="container">
		<nav id="footer" class="navbar navbar-default" role="navigation">
			<div class="navbar-text navbar-right">
				<a class="navbar-link" href="http://fr.lutece.paris.fr" target="lutece" title="#i18n{portal.site.portal_footer.labelPortal}">
					<img src="images/poweredby.png" alt="#i18n{portal.site.portal_footer.labelMadeBy}">
					<small>version ${version}</small>
				</a>
			</div>
		</nav>
	</div>
</footer>
<!-- Included JS Files -->
<!-- Le javascript
=============================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<@coreAdminJSLinks />
</#macro>

<#-- MACRO adminHome -->
<#macro adminHome >
<section class="dashboard-widgets">
<@row>
	<@columns class='widget'>
		${dashboard_zone_1!}
	</@columns>
	<@columns class='widget'>
		${dashboard_zone_2!}
	</@columns>
	<@columns class='widget'>
		${dashboard_zone_3!}
	</@columns>
</@row>
</section>
</#macro>

<#-- adminContentHeader  -->
<#macro adminContentHeader >
<header>
	<div class="row justify-content-between">
		<div class="col">
			<h3 class="ml-2">
				<a href="${feature_url}" title="${feature_title}">${feature_title}</a>
				<#if page_title?has_content><small>${page_title}</small></#if>
			</h3>
		</div>
		<@adminHeaderDocumentationLink />
	</div>
</header>
<section class="content <#if feature_url?ends_with('AdminSite.jsp')>no-padding</#if>">
</#macro>

<#-- adminLoginPage  -->
<#macro adminLoginPage title='' site_name='SITE_NAME'>
<img src="images/logo-header.png" class="fixed-top m-4" aria-hidden="true" title="LUTECE Back-Office" alt="LUTECE Back-Office">
<section id="login-page">
	<div class="container">
		<div class="row align-items-center vh-100">
			<div class="col-sm-5 offset-sm-3 bg-light rounded px-5">
				<header>
					<h1 class="h2 mb-3 text-center">
						<a class="btn btn-link btn-block " href="jsp/site/Portal.jsp" title="${site_name!'Lutece'}">#i18n{portal.admin.admin_login.welcome}<br> <b>${site_name!'Lutece'}</b></a>
					</h1>
					<h2 class="h3 mb-3 text-center">${title}</h2>
				</header>
				<main>
					<#nested>
				</main>
				<footer>
					<p class="text-center">
						<@aButton href='http://fr.lutece.paris.fr' params='target="_blank"' title='#i18n{portal.site.portal_footer.labelPortal}' hideTitle=['all'] color='link'>
						<img src="images/poweredby.png" class="thumbnails" alt="logo lutece" title="Lutece">
						</@aButton>
					</p>
				</footer>
				</div>	
		</div>
	</div>
</section>
<script>
$(function() {
	var randomImages = [#dskey{portal.site.site_property.back_images}];
	var rndNum = Math.floor(Math.random()*(randomImages.length));
	var bgImg = 'url(' + randomImages[rndNum] + ')';
	$("#login-page").css('background-image', bgImg );
});
</script>
</#macro>

<#-- adminHeaderDocumentationLink  -->
<#macro adminHeaderDocumentationLink >
  <#if feature_documentation?has_content >
		<#if feature_documentation?exists>
			<div class="col text-right">
				<a class="btn btn-link" target="_blank" href="${feature_documentation}" title="#i18n{portal.features.documentation.help} [Nouvelle fenêtre]">
					<@icon class="fa-life-ring" /> #i18n{portal.features.documentation.help}
				</a>
			</div>
		</#if>
	</#if>
</#macro>

<#macro adminSiteColumnOutline columnid=''>
<div class="admin_column_outline">
	<span class="admin_column_id">${i18n("portal.site.columnId",columnid)}</span>
	<div><#nested></div>
</div>
</#macro>

<#-- adminMessagePage  -->
<#macro adminMessagePage title=''>
<#assign title=title />
<#assign alerttype="secondary" />
<#assign icontype="fa-info-circle" />
<#if title??>
	<#if title?trim='' >
		<#assign title="Information" />
	</#if>		
</#if>		
<#if message.type == 2 >
	 <#assign alerttype="danger" />
   <#assign icontype="fa-question-circle" />
<#elseif message.type == 3 >
   <#assign alerttype="warning" />
   <#assign icontype="fa-exclamation-circle" />
<#elseif message.type == 4 >
	 <#assign alerttype="warning" />
   <#assign icontype="fa-question-circle" />
<#elseif message.type == 5 >
   <#assign alerttype="danger" />
   <#assign icontype="fa-ban" />
</#if>
<div class="container w-25">
	<div class="row justify-content-center align-items-center min-vh-100">
		<div class="col">
			<div class="alert alert-${alerttype} text-center" role="alert">
				<h1><span class="fas ${icontype}"></span> ${title!}</h1>
				${text!}
				<#nested>
				<p class="text-center">
					<img src="images/poweredby.png" class="thumbnails" alt="logo lutece" title="Lutece">
				</p>
			</div>	
		</div>
	</div>
</div>
</#macro>

<#-- fieldSet  -->
<#macro fieldSet legend=''>
<fieldset>
	<#if legend!=''>
		<legend>${legend}</legend>
	</#if>
	<#nested>
</fieldset>
</#macro>

<#--Badge : BS badge + label  -->
<#macro badge color='primary' badgeIcon='' title='' htmlEl='deprecated' type='deprecated' style='deprecated' class='deprecated' >
<span class="badge badge-${color}" <#if title != ''> title="${title}" </#if> >
    <#if badgeIcon !=''>
        <@icon style=badgeIcon />
    </#if>
	<#nested>
</span>
</#macro>



<#-- HELPERS --> 

<#-- FLOAT -->
<#-- Float right  -->
<#macro fright> float-right</#macro>
<#-- Float left  -->
<#macro fright> float-left</#macro>
<#-- Clearfix  -->
<#macro fright> clearfix</#macro>

<#-- RESPONSIVE -->

<#-- HTML ELEMENTS -->
<#macro img url='' alt='' title='' class='' id='' params=''> 
<img src="${url}" alt="${alt}" title="${title}" class="thumbnails thumb-list ${class}" id="${id}" ${params}>
</#macro>

<#-- Email Default Template -->
<#macro emailTemplate title='Lutece' footer_link='https://fr.lutece.paris.fr'> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width"/>
    <style type="text/css">
		* { margin: 0; padding: 0; font-size: 100%; font-family: 'Avenir Next', "Helvetica Neue", "Helvetica", Helvetica, Arial, sans-serif; line-height: 1.65; }
		img { max-width: 100%; margin: 0 auto; display: block; }
		body, .body-wrap { width: 100% !important; height: 100%; background: #f8f8f8; }
		a { color: #007bff; text-decoration: none; }
		a:hover { text-decoration: underline; }
		.text-center { text-align: center; }
		.text-right { text-align: right; }
		.text-left { text-align: left; }
		.button { display: inline-block; color: white; background: #007bff; border: solid #007bff; border-width: 10px 20px 8px; font-weight: bold; border-radius: 4px; }
		.button:hover { text-decoration: none; }
		h1, h2, h3, h4, h5, h6 { margin-bottom: 20px; line-height: 1.25; }
		h1 { font-size: 32px; }
		h2 { font-size: 28px; }
		h3 { font-size: 24px; }
		h4 { font-size: 20px; }
		h5 { font-size: 16px; }
		p, ul, ol { font-size: 16px; font-weight: normal; margin-bottom: 20px; }
		.container { display: block !important; clear: both !important; margin: 0 auto !important; max-width: 580px !important; }
		.container table { width: 100% !important; border-collapse: collapse; }
		.container .masthead { padding: 80px 0; background: #007bff; color: white; }
		.container .masthead h1 { margin: 0 auto !important; max-width: 90%; text-transform: uppercase; }
		.container .content { background: white; padding: 30px 35px; }
		.container .content.footer { background: none; }
		.container .content.footer p { margin-bottom: 0; color: #888; text-align: center; font-size: 14px; }
		.container .content.footer a { color: #888; text-decoration: none; font-weight: bold; }
		.container .content.footer a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<table class="body-wrap">
	<tr>
		<td class="container">
				<!-- Message start -->
				<table>
						<tr>
							<td align="center" class="masthead">
								<h1>${title}</h1>
							</td>
						</tr>
						<tr>
							<td class="content">
								<#nested>
							</td>
						</tr>
				</table>
		</td>
	</tr>
	<tr>
		<td class="container">
			<!-- Message start -->
			<table>
					<tr>
						<td class="content footer" align="center">
								<p><a href="${footer_link}">Lutece</a></p>
						</td>
					</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>		
</#macro>

<#macro adminLanguage languages lang action='jsp/admin/DoChangeLanguage.jsp' >
<@tform method='post' action=action class='form-inline'>
	<@input type='hidden' name='token' value='${token}' />
	<@row>
		<@columns class="mx-4">
			<@icon style='language' /> #i18n{portal.admin.admin_home.language}
		</@columns>
	</@row>
	<@row>
		<#list languages as language>
		<@columns>
			<#if lang=language.code>
				<#assign islocale='check-circle text-success pl-4'>
				<#assign title=' Selectionné '>
			<#else>
				<#assign islocale=''>
				<#assign title=''>
			</#if>
			<@button color='' class='${language.code}' type='submit' name='language' value='${language.code}' title='${language.name?capitalize}${title}' buttonIcon='${islocale}' hideTitle=['all'] showTitle=false />
		</@columns>
		</#list>
	</@row>
</@tform>
</#macro>

<#macro adminAccessibilityMode>
<@tform method='post' action='jsp/admin/DoModifyAccessibilityMode.jsp' class="ml-2">
	<@input type='hidden' name='token' value='${token}' />
	<#if user.accessibilityMode>
		<@button color='link text-dark' size='sm' type='submit' buttonIcon='eye' title='#i18n{portal.users.admin_header.labelDeactivateAccessibilityMode}'/>
	<#else>
		<@button color='link text-dark' size='sm' type='submit' buttonIcon='eye-slash' title='#i18n{portal.users.admin_header.labelActivateAccessibilityMode}'/>
	</#if>
</@tform>
</#macro>

<#-- adminContentHeader  -->
<#macro adminContentHeader >
<section class="content-header">
	<h1>
	<#if feature_url?? >
		<@link href='${feature_url}' title='${feature_title!""}'>${feature_title!''}</@link>
	<#else>
		${feature_title!''}
	</#if>
	<#if page_title?has_content><small>${page_title}</small></#if>
	</h1>
	<@adminHeaderDocumentationLink />
</section>
<section class="content <#if feature_url?? && feature_url?ends_with('AdminSite.jsp')>no-padding</#if>">
</#macro>