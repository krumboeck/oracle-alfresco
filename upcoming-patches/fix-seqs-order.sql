
--ASSIGN:alf_activity_feed_seq_next_value=value
select ALF_ACTIVITY_FEED_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_ACTIVITY_FEED_SEQ;
CREATE SEQUENCE ALF_ACTIVITY_FEED_SEQ START WITH ${alf_activity_feed_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_activity_feed_control_seq_next_value=value
select ALF_ACTIVITY_FEED_CONTROL_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_ACTIVITY_FEED_CONTROL_SEQ;
CREATE SEQUENCE ALF_ACTIVITY_FEED_CONTROL_SEQ START WITH ${alf_activity_feed_control_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_activity_post_seq_next_value=value
select ALF_ACTIVITY_POST_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_ACTIVITY_POST_SEQ;
CREATE SEQUENCE ALF_ACTIVITY_POST_SEQ START WITH ${alf_activity_post_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_audit_model_seq_next_value=value
select alf_audit_model_seq.nextval as value from dual;
DROP SEQUENCE ALF_AUDIT_MODEL_SEQ;
CREATE SEQUENCE ALF_AUDIT_MODEL_SEQ START WITH ${alf_audit_model_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_audit_app_seq_next_value=value
select alf_audit_app_seq.nextval as value from dual;
DROP SEQUENCE ALF_AUDIT_APP_SEQ;
CREATE SEQUENCE ALF_AUDIT_APP_SEQ START WITH ${alf_audit_app_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_audit_entry_seq_next_value=value
select alf_audit_entry_seq.nextval as value from dual;
DROP SEQUENCE ALF_AUDIT_ENTRY_SEQ;
CREATE SEQUENCE ALF_AUDIT_ENTRY_SEQ START WITH ${alf_audit_entry_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:avm_nodes_seq_next_value=value
select avm_nodes_seq.nextval as value from dual;
DROP SEQUENCE AVM_NODES_SEQ;
CREATE SEQUENCE AVM_NODES_SEQ START WITH ${avm_nodes_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:avm_store_properties_seq_next_value=value
select avm_store_properties_seq.nextval as value from dual;
DROP SEQUENCE AVM_STORE_PROPERTIES_SEQ;
CREATE SEQUENCE AVM_STORE_PROPERTIES_SEQ START WITH ${avm_store_properties_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:avm_stores_seq_next_value=value
select avm_stores_seq.nextval as value from dual;
DROP SEQUENCE AVM_STORES_SEQ;
CREATE SEQUENCE AVM_STORES_SEQ START WITH ${avm_stores_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:avm_version_roots_seq_next_value=value
select avm_version_roots_seq.nextval as value from dual;
DROP SEQUENCE AVM_VERSION_ROOTS_SEQ;
CREATE SEQUENCE AVM_VERSION_ROOTS_SEQ START WITH ${avm_version_roots_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_mimetype_seq_next_value=value
select alf_mimetype_seq.nextval as value from dual;
DROP SEQUENCE ALF_MIMETYPE_SEQ;
CREATE SEQUENCE ALF_MIMETYPE_SEQ START WITH ${alf_mimetype_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_encoding_seq_next_value=value
select alf_encoding_seq.nextval as value from dual;
DROP SEQUENCE ALF_ENCODING_SEQ;
CREATE SEQUENCE ALF_ENCODING_SEQ START WITH ${alf_encoding_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_content_url_seq_next_value=value
select alf_content_url_seq.nextval as value from dual;
DROP SEQUENCE ALF_CONTENT_URL_SEQ;
CREATE SEQUENCE ALF_CONTENT_URL_SEQ START WITH ${alf_content_url_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_content_data_seq_next_value=value
select alf_content_data_seq.nextval as value from dual;
DROP SEQUENCE ALF_CONTENT_DATA_SEQ;
CREATE SEQUENCE ALF_CONTENT_DATA_SEQ START WITH ${alf_content_data_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_lock_resource_seq_next_value=value
select alf_lock_resource_seq.nextval as value from dual;
DROP SEQUENCE ALF_LOCK_RESOURCE_SEQ;
CREATE SEQUENCE ALF_LOCK_RESOURCE_SEQ START WITH ${alf_lock_resource_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_lock_seq_next_value=value
select alf_lock_seq.nextval as value from dual;
DROP SEQUENCE ALF_LOCK_SEQ;
CREATE SEQUENCE ALF_LOCK_SEQ START WITH ${alf_lock_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_prop_class_seq_next_value=value
select alf_prop_class_seq.nextval as value from dual;
DROP SEQUENCE ALF_PROP_CLASS_SEQ;
CREATE SEQUENCE ALF_PROP_CLASS_SEQ START WITH ${alf_prop_class_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_prop_double_value_seq_next_value=value
select alf_prop_double_value_seq.nextval as value from dual;
DROP SEQUENCE ALF_PROP_DOUBLE_VALUE_SEQ;
CREATE SEQUENCE ALF_PROP_DOUBLE_VALUE_SEQ START WITH ${alf_prop_double_value_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_prop_string_value_seq_next_value=value
select alf_prop_string_value_seq.nextval as value from dual;
DROP SEQUENCE ALF_PROP_STRING_VALUE_SEQ;
CREATE SEQUENCE ALF_PROP_STRING_VALUE_SEQ START WITH ${alf_prop_string_value_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_prop_ser_value_seq_next_value=value
select alf_prop_ser_value_seq.nextval as value from dual;
DROP SEQUENCE ALF_PROP_SER_VALUE_SEQ;
CREATE SEQUENCE ALF_PROP_SER_VALUE_SEQ START WITH ${alf_prop_ser_value_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_prop_value_seq_next_value=value
select alf_prop_value_seq.nextval as value from dual;
DROP SEQUENCE ALF_PROP_VALUE_SEQ;
CREATE SEQUENCE ALF_PROP_VALUE_SEQ START WITH ${alf_prop_value_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_prop_root_seq_next_value=value
select alf_prop_root_seq.nextval as value from dual;
DROP SEQUENCE ALF_PROP_ROOT_SEQ;
CREATE SEQUENCE ALF_PROP_ROOT_SEQ START WITH ${alf_prop_root_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_prop_unique_ctx_seq_next_value=value
select alf_prop_unique_ctx_seq.nextval as value from dual;
DROP SEQUENCE ALF_PROP_UNIQUE_CTX_SEQ;
CREATE SEQUENCE ALF_PROP_UNIQUE_CTX_SEQ START WITH ${alf_prop_unique_ctx_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_locale_seq_next_value=value
select ALF_LOCALE_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_LOCALE_SEQ;
CREATE SEQUENCE ALF_LOCALE_SEQ START WITH ${alf_locale_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_namespace_seq_next_value=value
select ALF_NAMESPACE_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_NAMESPACE_SEQ;
CREATE SEQUENCE ALF_NAMESPACE_SEQ START WITH ${alf_namespace_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_qname_seq_next_value=value
select ALF_QNAME_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_QNAME_SEQ;
CREATE SEQUENCE ALF_QNAME_SEQ START WITH ${alf_qname_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_permission_seq_next_value=value
select ALF_PERMISSION_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_PERMISSION_SEQ;
CREATE SEQUENCE ALF_PERMISSION_SEQ START WITH ${alf_permission_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_ace_context_seq_next_value=value
select ALF_ACE_CONTEXT_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_ACE_CONTEXT_SEQ;
CREATE SEQUENCE ALF_ACE_CONTEXT_SEQ START WITH ${alf_ace_context_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_authority_seq_next_value=value
select ALF_AUTHORITY_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_AUTHORITY_SEQ;
CREATE SEQUENCE ALF_AUTHORITY_SEQ START WITH ${alf_authority_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_access_control_entry_seq_next_value=value
select ALF_ACCESS_CONTROL_ENTRY_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_ACCESS_CONTROL_ENTRY_SEQ;
CREATE SEQUENCE ALF_ACCESS_CONTROL_ENTRY_SEQ START WITH ${alf_access_control_entry_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_acl_change_set_seq_next_value=value
select ALF_ACL_CHANGE_SET_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_ACL_CHANGE_SET_SEQ;
CREATE SEQUENCE ALF_ACL_CHANGE_SET_SEQ START WITH ${alf_acl_change_set_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_access_control_list_seq_next_value=value
select ALF_ACCESS_CONTROL_LIST_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_ACCESS_CONTROL_LIST_SEQ;
CREATE SEQUENCE ALF_ACCESS_CONTROL_LIST_SEQ START WITH ${alf_access_control_list_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_acl_member_seq_next_value=value
select ALF_ACL_MEMBER_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_ACL_MEMBER_SEQ;
CREATE SEQUENCE ALF_ACL_MEMBER_SEQ START WITH ${alf_acl_member_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_authority_alias_seq_next_value=value
select ALF_AUTHORITY_ALIAS_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_AUTHORITY_ALIAS_SEQ;
CREATE SEQUENCE ALF_AUTHORITY_ALIAS_SEQ START WITH ${alf_authority_alias_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_server_seq_next_value=value
select ALF_SERVER_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_SERVER_SEQ;
CREATE SEQUENCE ALF_SERVER_SEQ START WITH ${alf_server_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_transaction_seq_next_value=value
select ALF_TRANSACTION_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_TRANSACTION_SEQ;
CREATE SEQUENCE ALF_TRANSACTION_SEQ START WITH ${alf_transaction_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_store_seq_next_value=value
select ALF_STORE_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_STORE_SEQ;
CREATE SEQUENCE ALF_STORE_SEQ START WITH ${alf_store_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_node_seq_next_value=value
select ALF_NODE_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_NODE_SEQ;
CREATE SEQUENCE ALF_NODE_SEQ START WITH ${alf_node_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_child_assoc_seq_next_value=value
select ALF_CHILD_ASSOC_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_CHILD_ASSOC_SEQ;
CREATE SEQUENCE ALF_CHILD_ASSOC_SEQ START WITH ${alf_child_assoc_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_node_assoc_seq_next_value=value
select ALF_NODE_ASSOC_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_NODE_ASSOC_SEQ;
CREATE SEQUENCE ALF_NODE_ASSOC_SEQ START WITH ${alf_node_assoc_seq_next_value} INCREMENT BY 1 ORDER;

--ASSIGN:alf_usage_delta_seq_next_value=value
select ALF_USAGE_DELTA_SEQ.nextval as value from dual;
DROP SEQUENCE ALF_USAGE_DELTA_SEQ;
CREATE SEQUENCE ALF_USAGE_DELTA_SEQ START WITH ${alf_usage_delta_seq_next_value} INCREMENT BY 1 ORDER;

