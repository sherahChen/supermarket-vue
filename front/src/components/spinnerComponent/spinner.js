import { Indicator } from 'mint-ui';

export default{
    loadspinner: function () {
        Indicator.open({
            text: '加载中...',
            spinnerType: 'fading-circle'
        });
    },
    closeSpinner: function () {
        Indicator.close();
    }
}