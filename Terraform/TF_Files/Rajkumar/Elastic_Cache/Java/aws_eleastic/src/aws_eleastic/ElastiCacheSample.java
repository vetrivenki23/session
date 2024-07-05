import redis.clients.jedis.Jedis;

public class ElastiCacheSample {

    public static void main(String[] args) {
        // Redis instance connection details
        String redisEndpoint = "your-redis-cluster.xxxxxx.ng.0001.use1.cache.amazonaws.com";
        int redisPort = 6379;
        String redisPassword = "your_redis_password";

        // Connect to Redis
        Jedis jedis = new Jedis(redisEndpoint, redisPort);
        jedis.auth(redisPassword);

        // Set a key-value pair
        jedis.set("myKey", "Hello ElasticCache!");

        // Retrieve and print the value
        String value = jedis.get("myKey");
        System.out.println("Value retrieved from Redis: " + value);

        // Close the connection
        jedis.close();
    }
}
