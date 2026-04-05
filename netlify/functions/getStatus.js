exports.handler = async (event, context) => {
    // Memberikan kredensial Supabase dari Environment Variables Netlify
    const supabaseConfig = {
        supabaseUrl: process.env.SUPABASE_URL,
        supabaseAnonKey: process.env.SUPABASE_ANON_KEY
    };

    return {
        statusCode: 200,
        headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
        },
        body: JSON.stringify(supabaseConfig),
    };
};
