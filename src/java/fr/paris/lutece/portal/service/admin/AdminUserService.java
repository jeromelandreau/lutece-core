/*
 * Copyright (c) 2002-2010, Mairie de Paris
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice
 *     and the following disclaimer.
 *
 *  2. Redistributions in binary form must reproduce the above copyright notice
 *     and the following disclaimer in the documentation and/or other materials
 *     provided with the distribution.
 *
 *  3. Neither the name of 'Mairie de Paris' nor 'Lutece' nor the names of its
 *     contributors may be used to endorse or promote products derived from
 *     this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * License 1.0
 */
package fr.paris.lutece.portal.service.admin;

import fr.paris.lutece.portal.business.user.AdminUser;
import fr.paris.lutece.portal.business.user.AdminUserFilter;
import fr.paris.lutece.portal.business.user.AdminUserHome;
import fr.paris.lutece.portal.business.user.attribute.AdminUserFieldFilter;
import fr.paris.lutece.portal.business.user.attribute.AdminUserFieldHome;
import fr.paris.lutece.portal.business.user.attribute.AttributeField;
import fr.paris.lutece.portal.business.user.attribute.AttributeFieldHome;
import fr.paris.lutece.portal.business.user.attribute.AttributeHome;
import fr.paris.lutece.portal.business.user.attribute.IAttribute;
import fr.paris.lutece.portal.service.util.AppPropertiesService;
import fr.paris.lutece.util.url.UrlItem;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


/**
 * This service provides features concerning the administration users
 */
public final class AdminUserService
{
	// PROPERTIES
    private static final String PROPERTY_ADMINISTRATOR = "right.administrator";
    
    // MARKS
    private static final String MARK_SEARCH_IS_SEARCH = "search_is_search";
    private static final String MARK_SEARCH_ADMIN_USER_FILTER = "search_admin_user_filter";
    private static final String MARK_SEARCH_ADMIN_USER_FIELD_FILTER = "search_admin_user_field_filter";
    private static final String MARK_ATTRIBUTES_LIST = "attributes_list";
    private static final String MARK_LOCALE = "locale";
    private static final String MARK_SORT_SEARCH_ATTRIBUTE = "sort_search_attribute";

    /** Private constructor */
    private AdminUserService(  )
    {
    }

    /**
     * Get the user in session
     * @param request The HTTP request
     * @return the user in session
     */
    public static AdminUser getAdminUser( HttpServletRequest request )
    {
        return AdminAuthenticationService.getInstance(  ).getRegisteredUser( request );
    }

    /**
     * Get the locale for the current request
     * @param request The HTTP request
     * @return the locale to use with this request
     */
    public static Locale getLocale( HttpServletRequest request )
    {
        // Default value is JVM locale
        Locale locale = Locale.getDefault(  );
        AdminUser user = getAdminUser( request );

        if ( user != null )
        {
            // Take the locale of the current user if exists
            locale = user.getLocale(  );
        }
        else
        {
            // TODO : Add cookie search

            // Take the locale of the browser
            locale = request.getLocale(  );
        }

        return locale;
    }

    /**
     * Gets the admin right level
     *
     * @param request The HTTP request
     * @return The boolean level right
     */

    // TODO : move somewhere else or could be removed ?
    public static boolean getUserAdminRightLevel( HttpServletRequest request )
    {
        String strRightCode = AppPropertiesService.getProperty( PROPERTY_ADMINISTRATOR );

        AdminUser user = getAdminUser( request );
        boolean bLevelRight = user.checkRight( strRightCode );

        return bLevelRight;
    }
    
    /**
     * Get the filtered list of admin users
     * @param listUsers the initial list of users
     * @param request HttpServletRequest
     * @param model map
     * @param url URL of the current interface
     * @return The filtered list of admin users
     */
    public static List<AdminUser> getFilteredUsersInterface
    	( List<AdminUser> listUsers, HttpServletRequest request, Map<String, Object> model, UrlItem url )
    {
    	AdminUser currentUser = getAdminUser( request );
    	
    	// FILTER
        AdminUserFilter auFilter = new AdminUserFilter(  );
        List<AdminUser> listFilteredUsers = new ArrayList<AdminUser>(  );
        boolean bIsSearch = auFilter.setAdminUserFilter( request );
        boolean bIsFiltered;
        
        for ( AdminUser filteredUser : AdminUserHome.findUserByFilter( auFilter ) )
        {
        	bIsFiltered = Boolean.FALSE;
        	
        	for( AdminUser user : listUsers )
        	{
        		if ( user.getUserId(  ) == filteredUser.getUserId(  ) )
                {
            		bIsFiltered = Boolean.TRUE;
            		break;
                }
        	}
        	
        	if ( bIsFiltered &&
                    ( ( currentUser.isParent( filteredUser ) || ( currentUser.isAdmin(  ) ) ) ) )
            {
        		listFilteredUsers.add( filteredUser );
            }
        }
        
        List<AdminUser> filteredUsers = new ArrayList<AdminUser>(  );
        
    	AdminUserFieldFilter auFieldFilter= new AdminUserFieldFilter(  );
        auFieldFilter.setAdminUserFieldFilter( request, currentUser.getLocale(  ) );
        List<AdminUser> listFilteredUsersByUserFields = AdminUserFieldHome.findUsersByFilter( auFieldFilter );
        
        if ( listFilteredUsersByUserFields != null )
        {
        	for ( AdminUser filteredUser : listFilteredUsers )
            {
            	for ( AdminUser filteredUserByUserField : listFilteredUsersByUserFields )
            	{
            		if ( filteredUser.getUserId(  ) == filteredUserByUserField.getUserId(  ) )
            		{
            			filteredUsers.add( filteredUser );
            		}
            	}
            }
        }
        else
        {
        	filteredUsers = listFilteredUsers;
        }
        
        List<IAttribute> listAttributes = AttributeHome.findAll( currentUser.getLocale(  ) );
        for ( IAttribute attribute : listAttributes )
        {
        	List<AttributeField> listAttributeFields = AttributeFieldHome.selectAttributeFieldsByIdAttribute( attribute.getIdAttribute(  ) );
        	attribute.setListAttributeFields( listAttributeFields );
        }
        
        String strSortSearchAttribute = "";
        if( bIsSearch )
        {
        	auFilter.setUrlAttributes( url );
        	strSortSearchAttribute = "&" + auFilter.getUrlAttributes(  );
        	auFieldFilter.setUrlAttributes( url );
        	strSortSearchAttribute = auFieldFilter.getUrlAttributes(  );
        }
        
        model.put( MARK_SEARCH_ADMIN_USER_FILTER, auFilter );
        model.put( MARK_SEARCH_IS_SEARCH, bIsSearch );
        model.put( MARK_SEARCH_ADMIN_USER_FIELD_FILTER, auFieldFilter );
        model.put( MARK_LOCALE, currentUser.getLocale(  ) );
        model.put( MARK_ATTRIBUTES_LIST, listAttributes );
        model.put( MARK_SORT_SEARCH_ATTRIBUTE, strSortSearchAttribute );
        
        return filteredUsers;
    }
}
