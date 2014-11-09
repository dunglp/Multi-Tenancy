using System;
using System.Collections.Concurrent;
using System.Data.Common;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using UrlRouting.Models.Entity;

namespace UrlRouting.Models
{
    public class DatabaseConnection : DbContext
    {
        public virtual DbSet<User> Users { get; set; }

        private DatabaseConnection(DbConnection connection, DbCompiledModel model)
            : base(connection, model, contextOwnsConnection: false)
        {
            Database.SetInitializer<DatabaseConnection>(null);
        }

        /// <summary>
        /// Cache for improving performance
        /// </summary>
        private static ConcurrentDictionary<Tuple<string, string>, DbCompiledModel> modelCache = new ConcurrentDictionary<Tuple<string, string>, DbCompiledModel>();

        public static DatabaseConnection Create(string userSchema, DbConnection connection)
        {
            var compiledModel = modelCache.GetOrAdd(
                Tuple.Create(connection.ConnectionString, userSchema),
                t =>
                {
                    var builder = new DbModelBuilder();

                    builder.Conventions.Remove<IncludeMetadataConvention>();                        
                    builder.Entity<User>().ToTable("User", userSchema);

                    var model = builder.Build(connection);
                    return model.Compile();
                });

            return new DatabaseConnection(connection, compiledModel);
        }

        public static void ProvisionTenant(string tenantSchema, DbConnection connection)
        {
            using (var ctx = Create(tenantSchema, connection))
            {
                if (!ctx.Database.Exists())
                {
                    ctx.Database.Create();
                }
                else
                {
                    var createScript = ((IObjectContextAdapter)ctx).ObjectContext.CreateDatabaseScript();
                    ctx.Database.ExecuteSqlCommand(createScript);
                }
            }
        }
        
    }
}