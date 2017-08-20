package xu.li.cordova.tongdun;

import android.util.Log;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaArgs;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONException;

import cn.tongdun.android.shell.FMAgent;

public class TongDun extends CordovaPlugin
{
    public static final String TAG = "Cordova.Plugin.TongDun";

    @Override
    protected void pluginInitialize()
    {
        super.pluginInitialize();

        if (preferences.getBoolean("tongdun_sandbox", false)) {
            FMAgent.init(cordova.getActivity(), FMAgent.ENV_SANDBOX);
        } else {
            FMAgent.init(cordova.getActivity(), FMAgent.ENV_PRODUCTION);
        }
    }

    @Override
    public boolean execute(String action, CordovaArgs args, CallbackContext callbackContext) throws JSONException {
        Log.d(TAG, String.format("%s is called. Callback ID: %s.", action, callbackContext.getCallbackId()));

        if (action.equals("getSignature")) {
            return getSignature(callbackContext);
        }

        return false;
    }

    protected boolean getSignature(CallbackContext callbackContext) {
        String signature = FMAgent.onEvent(cordova.getActivity());

        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, signature));

        return true;
    }
}
