#include <stdlib.h>

typedef enum {
	GCONF_VALUE_NONE,
	GCONF_VALUE_STRING,
	GCONF_VALUE_INTEGER,
	GCONF_VALUE_DOUBLE,
	GCONF_VALUE_BOOLEAN,
	GCONF_VALUE_SCHEMA,
	GCONF_VALUE_LIST,
	GCONF_VALUE_PAIR,
} GConfValueType;

typedef struct xx GConfClient;
typedef struct xy GConfValue;
typedef struct xz GError;

typedef char gchar;
typedef double gdouble;
typedef void* gpointer;

void
g_clear_error(GError**err) {
	*err = NULL;
}

void
g_object_unref(gpointer object) {
}

void
g_type_init() {
}

GConfValue*
gconf_client_get(GConfClient*client, const gchar*key, GError**err) {
	return NULL;
}

GConfClient*
gconf_client_get_default() {
	return NULL;
}

void
gconf_client_set(GConfClient*client, const gchar*key, const GConfValue*val, GError**err) {
}

void
gconf_value_free(GConfValue*value) {
}

int
gconf_value_get_int(const GConfValue*value) {
	return 0;
}

GConfValue*
gconf_value_new(GConfValueType type) {
	return NULL;
}

void
gconf_value_set_float(GConfValue*value, gdouble the_float) {
}
