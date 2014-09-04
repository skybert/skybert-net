title: Analysing log files
date:    2012-10-07
category: escenic

To get an overview of which ERRORs you're getting the most of,
this command will give you a nice quick overview:

```
$ grep ERROR pres1-engine1-messages | cut -d' ' -f6- | sort | uniq -c | sort -n -r
50 (com.escenic.poll.struts.HandleSubmitAction) Mentometer is null.
50 (com.escenic.poll.struts.HandleSubmitAction) mentometerId not defined
25 (com.escenic.framework.search.solr.SolrSearchEngine) solr search failed
25 (com.escenic.framework.search.solr.action.SearchAction) Error while executing search
19 (org.apache.struts.actions.DispatchAction) Request[/pageTools/sendMail] does not contain handler parameter named 'method'.  This may be caused by whitespace in the label text.
12 (org.apache.struts.action.RequestProcessor) Invalid path was requested /forum/addcaptchacomment
11 (org.apache.struts.action.RequestProcessor) Invalid path was requested /pagetools/sendmail
9 (org.apache.xmlrpc.server.XmlRpcErrorLogger) Failed to parse XML-RPC request: Content is not allowed in prolog.
6 (com.escenic.framework.servlet.contactform.SendFeedback) Invalid captcha words
4 (com.mysite.tags.GetArticleStatistics) Exception: fromDate can't be null
4 (com.escenic.framework.geo.GeoLocationCheckService) Error while checking non public ip
4 (com.escenic.framework.geo.GeoIPLookupManager) The Nursery component /com/escenic/framework/geo/GeoLookupManager hasn't been configured properly.
2 (com.escenic.framework.search.solr.SolrHttpClient) Error while sending request to Solr
1 UpdatingThread[0]] objectId:558188 (neo.xredsys.presentation.ArticlePresentationManager) Could not create PresentationArticle of article with id = 558188:
1 (org.apache.struts.action.RequestProcessor) Invalid path was requested /entertainment/fashion/forum/addCaptchaComment
1 [*]/neo/io/managers/PluginManager] (neo.xredsys.plugin.Plugin) Error parsing plugin analysis-engine. Service specified but component did not exist in the Nursery: /com/escenic/analysis/EaePlugin
escenic
```


